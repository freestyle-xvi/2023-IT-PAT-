unit SignUpPage_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, frmDataModuleEcoCyber_U, StrUtils, DateUtils, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTPBase, IdSMTP, IdMessage, IdText,
  IdAttachmentFile, IdExplicitTLSClientServerBase,
  IdSSL, IdSSLOpenSSL, AdminCodeManager;

type
  TfrmSignUpPage = class(TForm)
    pnlSUP: TPanel;
    imgSignUpPageUI: TImage;
    rgpSignUpPageUserTypeField: TRadioGroup;
    edtSignUpPageNameField: TEdit;
    edtSignUpPageLastNameField: TEdit;
    edtSignUpPageUsernameField: TEdit;
    edtSignUpPageEmailField: TEdit;
    edtSignUpPagePasswordField: TEdit;
    HomeButtonSP: TImage;
    imgSignUpBTN: TImage;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    procedure HomeButtonSPClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgSignUpBTNClick(Sender: TObject);
  private
    { Private declarations }
    procedure SendAdminEmail(const adminEmail: string; const adminCode: string);

  public
    adminEmail: string;
    adminCode: integer;

    { Public declarations }
  end;

var
  frmSignUpPage: TfrmSignUpPage;
  sName, sLastName, sUsername, sEmail, sPassword: string;
  // Combine declarations for improved readability

implementation

uses frmLoginPage_U, frmHomePage_U, frmAdminDashboard_U, frmSaveThePlanetXVI_U,
  frmLoadingScreen_U;

{$R *.dfm}

procedure TfrmSignUpPage.imgSignUpBTNClick(Sender: TObject);
var
  UsernameSpaceValidation, EmailValidation, PasswordSpaceValidation,
    EmptyFieldValidation, UserTypeSelected: Boolean;
  i: integer;
  NamesLastNameFile: TextFile;
  CurrentDate: TDate;
  ExistingUser: Boolean;
  sLine, date: string;
  AdminCodeMgr: TAdminCodeManager;
begin

  // initialising validation state
  EmptyFieldValidation := false;
  EmailValidation := false;
  PasswordSpaceValidation := true;

  // Initialize variables
  sName := edtSignUpPageNameField.Text;
  sLastName := edtSignUpPageLastNameField.Text;
  sUsername := edtSignUpPageUsernameField.Text;
  sEmail := edtSignUpPageEmailField.Text;
  sPassword := edtSignUpPagePasswordField.Text;

  // Validation checks
  if Length(sUsername) < 6 then
  begin
    ShowMessage('Username must be at least 6 characters');
    Exit;
  end;

  // Username Space Validation
  if Pos(' ', sUsername) > 0 then
  begin
    ShowMessage('Username may not contain spaces!');
    Exit;
  end;

  // Email Validation
  if not Pos('@gmail.com', LowerCase(sEmail)) > 0 then
  begin
    ShowMessage('Invalid Email - use the format example@gmail.com');
    Exit;
  end;

  // Password Validation
  if (Length(sPassword) < 6) or (Pos(' ', sPassword) > 0) then
  begin
    ShowMessage('Password must be at least 6 characters and no spaces');
    Exit;
  end;

  // Check if a user type is selected
  if rgpSignUpPageUserTypeField.ItemIndex = -1 then
  begin
    ShowMessage('Please select a user type.');
    Exit;
  end;

  // Database operations
  if dmEC.tblUsers.Locate('Username', sUsername, []) then
  begin
    ShowMessage('Username already exists. Choose a different username.');
    Exit;
  end;

  // Check for empty fields
  if (Length(sName) = 0) or (Length(sLastName) = 0) or (Length(sUsername) = 0)
    or (Length(sEmail) = 0) or (Length(sPassword) = 0) or
    (not PasswordSpaceValidation) or (not EmailValidation) then
  begin
    ShowMessage
      ('One or more fields may have not been filled and/or may be invalid!');
    Exit; // Abort sign-up process if any fields are empty or invalid
  end;

  // Check if the username already exists in the database
  ExistingUser := dmEC.tblUsers.Locate('Username', sUsername, []);
  if ExistingUser then
  begin
    ShowMessage('Username already exists. Please choose a different username.');
    Exit;
  end;

  // Check if the user selected "Admin" user type
  if rgpSignUpPageUserTypeField.Items[rgpSignUpPageUserTypeField.ItemIndex] = 'Admin'
  then
  begin
    // Generate and send the admin email
    adminEmail := edtSignUpPageEmailField.Text;
    // generates code to be put in email
    AdminCodeMgr := TAdminCodeManager.Create;
    try
      adminCode := AdminCodeMgr.GenerateAndSaveCode;
      ShowMessage('Generated Admin Code: ' + IntToStr(adminCode));
    finally
      AdminCodeMgr.Free;
    end;
    // sends email
    SendAdminEmail(adminEmail, IntToStr(adminCode));
  end;

  // Database operation
  dmEC.tblUsers.Append;
  dmEC.tblUsers['Username'] := edtSignUpPageUsernameField.Text;
  dmEC.tblUsers['Password'] := edtSignUpPagePasswordField.Text;
  dmEC.tblUsers['UserType'] := rgpSignUpPageUserTypeField.Items
    [rgpSignUpPageUserTypeField.ItemIndex];
  dmEC.tblUsers['Email'] := edtSignUpPageEmailField.Text;
  dmEC.tblUsers['JoinedAtDate'] := date;
  dmEC.tblUsers.Post;

  // Save name and last name to the file
  AssignFile(NamesLastNameFile, 'NamesAndLastNamesEC.txt');
  if FileExists('NamesAndLastNamesEC.txt') then
    Append(NamesLastNameFile)
  else
    Rewrite(NamesLastNameFile);
  // formatting of line written to textfile
  Writeln(NamesLastNameFile, sUsername + ' ' + sName + ' ' + sLastName);
  CloseFile(NamesLastNameFile);

  // Show success message and close the sign-up form
  ShowMessage('You have officially Signed Up');
  frmSignUpPage.Close;
  frmLoginPage.Show;
end;

procedure TfrmSignUpPage.SendAdminEmail(const adminEmail, adminCode: string);
var
  SMTP: TIdSMTP;
  Msg: TIdMessage;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin

  // initiliasing of variables and components
  SMTP := TIdSMTP.Create(nil);
  Msg := TIdMessage.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configure SMTP settings for Gmail
    SMTP.Host := 'smtp.gmail.com';
    SMTP.Port := 587;
    SMTP.Username := 'm.hasanalware@gmail.com'; // Your Gmail email address
    SMTP.Password := 'oktdeietszcoxwqz'; // App-specific password

    // Enable TLS encryption
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SMTP.IOHandler := SSLHandler;

    // Compose the email message
    Msg.From.Address := 'm.hasanalware@gmail.com';
    Msg.Recipients.Add.Address := adminEmail;
    Msg.Subject := 'Admin Code';
    Msg.Body.Text := 'Your admin code is: ' + adminCode;

    // StartTLS command
    SMTP.UseTLS := utUseExplicitTLS;

    // Send the email
    SMTP.Connect;
    try
      SMTP.Send(Msg);
    finally
      SMTP.Disconnect;
    end;
    ShowMessage('Admin code email sent successfully.');
  finally
    FreeAndNil(SMTP);
    FreeAndNil(Msg);
    FreeAndNil(SSLHandler);
  end;

end;

procedure TfrmSignUpPage.FormCreate(Sender: TObject);
begin
  // Align the form in the center of the screen
  Left := (Screen.Width - Width) div 2;
  Top := (Screen.Height - Height) div 2;
end;

procedure TfrmSignUpPage.HomeButtonSPClick(Sender: TObject);
begin
  // returns to start up page
  frmSignUpPage.Close;

  frmLoadingScreen := TfrmLoadingScreen.Create(nil);
  try
    frmLoadingScreen.ShowModal;
    // Code to perform any necessary operations or load data
    frmStartupPage.Show; // Opens the destination form after the loading screen
  finally
    frmLoadingScreen.Free;
  end;

end;

end.
