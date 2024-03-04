unit EcoCyberEvents_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.ComCtrls, StrUtils, Math, Vcl.CheckLst, Vcl.MPlayer,
  frmDataModuleEcoCyber_U, Vcl.OleCtrls, WMPLib_TLB;

type
  TfrmEcoCyberEvents = class(TForm)
    Image1: TImage;
    btnAirEmission: TButton;
    pnLAEC: TPanel;
    imgReturnAECpnl: TImage;
    imgAEC: TImage;
    lblHeading: TLabel;
    lblDistanceQ: TLabel;
    edtDistance: TEdit;
    richEditDistance: TRichEdit;
    btnAECCalculate: TButton;
    btnPTVC: TButton;
    pnlPTVC: TPanel;
    imgPTPT: TImage;
    imgReturnPTPTpnl: TImage;
    lblTitle: TLabel;
    EditDistance: TEdit;
    EditFuelEfficiency: TEdit;
    EditPublicTransportFare: TEdit;
    EditNumTrips: TEdit;
    lblDistance: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnCalcPTVC: TButton;
    memoResult: TMemo;
    btnCRP: TButton;
    pnlCRP: TPanel;
    imgCRP: TImage;
    imgReturnCPOFpnl: TImage;
    ButtonSubmit: TButton;
    MemoPledges: TMemo;
    CheckListPledges: TCheckListBox;
    btnWatchVid1: TButton;
    pnlCCV1: TPanel;
    imgVGW: TImage;
    lblTitleCPA: TLabel;
    lblCPAinstructions: TLabel;
    lblTitleVGW: TLabel;
    imgReturnGWVpnl: TImage;
    btnWatchVid2: TButton;
    pnlCCV2: TPanel;
    imgCCV2ui: TImage;
    imgReturnGCDVpnl: TImage;
    lblTitleVid2: TLabel;
    imgReturnECEtoHomePage: TImage;
    btnQuiz1: TButton;
    pnlQuiz1: TPanel;
    imgQuiz1: TImage;
    imgReturnQuiz1: TImage;
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    btnPlay: TButton;
    WindowsMediaPlayer2: TWindowsMediaPlayer;
    btnPlayVid2: TButton;
    btnFirstQuiz: TButton;
    memoResults: TMemo;
    btnSecondQuiz: TButton;
    memoResults2: TMemo;
    btnThirdQuiz: TButton;
    memoResults3: TMemo;
    btnFourthQuiz: TButton;
    memoResults4: TMemo;
    btnFifthQuiz: TButton;
    memoResults5: TMemo;
    lblQuizUItitle: TLabel;
    procedure imgReturnAECpnlClick(Sender: TObject);
    procedure btnAirEmissionClick(Sender: TObject);
    procedure btnAECCalculateClick(Sender: TObject);
    procedure imgReturnPTPTpnlClick(Sender: TObject);
    procedure btnPTVCClick(Sender: TObject);
    procedure btnCalcPTVCClick(Sender: TObject);
    procedure imgReturnCPOFpnlClick(Sender: TObject);
    procedure ButtonSubmitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgReturnGWVpnlClick(Sender: TObject);
    procedure btnWatchVid1Click(Sender: TObject);
    procedure btnCRPClick(Sender: TObject);
    procedure imgReturnECEtoHomePageClick(Sender: TObject);
    procedure btnWatchVid2Click(Sender: TObject);
    procedure imgReturnGCDVpnlClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnPlayVid2Click(Sender: TObject);
    procedure btnFirstQuizClick(Sender: TObject);
    procedure imgReturnQuiz1Click(Sender: TObject);
    procedure btnQuiz1Click(Sender: TObject);
    procedure btnSecondQuizClick(Sender: TObject);
    procedure btnThirdQuizClick(Sender: TObject);
    procedure btnFourthQuizClick(Sender: TObject);
    procedure btnFifthQuizClick(Sender: TObject);
  private
    Pledges: array of string;
  public
    { Public declarations }
  end;

var
  frmEcoCyberEvents: TfrmEcoCyberEvents;

implementation

uses frmHomePage_U, frmLoginPage_U, SignUpPage_U;

{$R *.dfm}

procedure TfrmEcoCyberEvents.btnAECCalculateClick(Sender: TObject);
var
  distance, emissionFactor, TotalEmissions: double;
  CurrentActionDate: Tdate;
  ActionDate: string;
  AECPoints: integer;
  inputValid: Boolean; // Flag to indicate if input is valid

begin

  // Validate the input for distance
  inputValid := TryStrToFloat(edtDistance.Text, distance);
  if not inputValid then
  begin
    ShowMessage('Invalid distance input.');
    Exit;
  end;
  // code for Air emission calculations//
  distance := StrToFloat(edtDistance.Text);
  emissionFactor := 0.2;
  TotalEmissions := distance * emissionFactor;
  richEditDistance.Lines.Clear;
  richEditDistance.Lines.Add(Format('Total Emissions: %.2f kg CO2',
    [TotalEmissions], FormatSettings));

  // getting date of when action has occured
  CurrentActionDate := now;
  ActionDate := DateTimeToStr(CurrentActionDate);

  dmEC.tblEvents.Append;
  dmEC.tblEvents['UserID'] := frmLoginPage.UserID;
  dmEC.tblEvents['ActionType'] := 'Calculator';
  dmEC.tblEvents['ActionDate'] := ActionDate;
  dmEC.tblEvents['ActionDescription'] :=
    'Calculated personal CO2 emmissions based off of a flight distance';
  dmEC.tblEvents.post;

  AECPoints := 50;
  if dmEC.tblUsers.Locate('Username', LoggedInUser, []) then
  begin
    dmEC.tblUsers.Edit; // Start editing the current record
    dmEC.tblUsers.FieldByName('UserPoints').AsInteger :=
      dmEC.tblUsers.FieldByName('UserPoints').AsInteger + AECPoints;
    dmEC.tblUsers.post; // Save the changes
  end
  else
  begin
    ShowMessage('User not found in the database.');
    Exit;
  end;

end;

procedure TfrmEcoCyberEvents.btnAirEmissionClick(Sender: TObject);
begin
  pnLAEC.Align := alClient;
  pnLAEC.Show;
  imgAEC.Align := alClient;
end;

procedure TfrmEcoCyberEvents.btnCalcPTVCClick(Sender: TObject);
var
  distance: double;
  FuelEfficiency: double;
  PublicTransportFare: double;
  NumTrips: integer;
  CarEmissions: double;
  CarCost: double;
  PublicTransportEmissions: double;
  PublicTransportCost: double;
  CurrentActionDate: Tdate;
  ActionDate: string;
  PTvsPTPoints: integer;
begin
  try
    distance := StrToFloat(EditDistance.Text);
    FuelEfficiency := StrToFloat(EditFuelEfficiency.Text);
    PublicTransportFare := StrToFloat(EditPublicTransportFare.Text);
    NumTrips := StrToInt(EditNumTrips.Text);

    // Calculate car emissions and cost
    CarEmissions := distance * (FuelEfficiency / 100) * 2.3;
    // Example CO2 emissions per liter
    CarCost := distance * (1 / FuelEfficiency) * 1.5;
    // Example fuel cost per liter

    // Calculate public transport emissions and cost
    PublicTransportEmissions := NumTrips * CarEmissions * 0.7;
    // Example lower emissions factor for public transport
    PublicTransportCost := NumTrips * PublicTransportFare;

    memoResult.Lines.Clear;
    memoResult.Lines.Add(Format('Car Emissions: %.2f kg CO2', [CarEmissions]));
    memoResult.Lines.Add(Format('Car Cost: R%.2f', [CarCost]));
    memoResult.Lines.Add(Format('Public Transport Emissions: %.2f kg CO2',
      [PublicTransportEmissions]));
    memoResult.Lines.Add(Format('Public Transport Cost: R%.2f',
      [PublicTransportCost]));
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;

  // getting event details and posting event details in tblEvents
  CurrentActionDate := now;
  ActionDate := DateTimeToStr(CurrentActionDate);
  dmEC.tblEvents.Append;
  dmEC.tblEvents['UserID'] := frmLoginPage.UserID;
  dmEC.tblEvents['ActionType'] := 'Calculator';
  dmEC.tblEvents['ActionDate'] := ActionDate;
  dmEC.tblEvents['ActionDescription'] :=
    'Calculated The cost of public transport and private transport based off of cost and fuel efficiency';
  dmEC.tblEvents.post;

  // assigning points for events and posting points upon completion of calculation
  PTvsPTPoints := 75;
  if dmEC.tblUsers.Locate('Username', LoggedInUser, []) then
  begin
    dmEC.tblUsers.Edit; // Start editing the current record
    dmEC.tblUsers.FieldByName('UserPoints').AsInteger :=
      dmEC.tblUsers.FieldByName('UserPoints').AsInteger + PTvsPTPoints;
    dmEC.tblUsers.post; // Save the changes
  end
  else
  begin
    ShowMessage('User not found in the database.');
    Exit;
  end;

end;

procedure TfrmEcoCyberEvents.btnCRPClick(Sender: TObject);
begin
  pnlCRP.Show;
  pnlCRP.Align := alClient;
  imgCRP.Align := alClient;

end;

procedure TfrmEcoCyberEvents.btnFifthQuizClick(Sender: TObject);
var
  Questions: array [1 .. 5] of string;
  Options: array [1 .. 5, 1 .. 3] of string;
  CorrectAnswers: array [1 .. 5] of Char;
  UserAnswers: array [1 .. 5] of Char;
  i: integer;
  ActionDate: string;
  CurrentActionDate: Tdate;
  QuizPoints: integer;
begin
  // Set up questions, options, and correct answers
  Questions[1] :=
    'What is the practice of planting trees to restore or create a forest called?';
  Options[1, 1] := 'a) Afforestation';
  Options[1, 2] := 'b) Deforestation';
  Options[1, 3] := 'c) Desertification';
  CorrectAnswers[1] := 'a';

  Questions[2] :=
    'What is the term for the sustainable use of natural resources to meet human needs without depleting them?';
  Options[2, 1] := 'a) Conservation';
  Options[2, 2] := 'b) Exploitation';
  Options[2, 3] := 'c) Extraction';
  CorrectAnswers[2] := 'a';

  Questions[3] :=
    'What is the process of converting waste materials into reusable materials called?';
  Options[3, 1] := 'a) Incineration';
  Options[3, 2] := 'b) Landfilling';
  Options[3, 3] := 'c) Recycling';
  CorrectAnswers[3] := 'c';

  Questions[4] :=
    'Which type of energy uses heat from the Earth''s interior to generate electricity?';
  Options[4, 1] := 'a) Geothermal';
  Options[4, 2] := 'b) Hydroelectric';
  Options[4, 3] := 'c) Nuclear';
  CorrectAnswers[4] := 'a';

  Questions[5] :=
    'What is the process of capturing and storing carbon dioxide emissions from industrial sources called?';
  Options[5, 1] := 'a) Carbon Sequestration';
  Options[5, 2] := 'b) Carbon Emission';
  Options[5, 3] := 'c) Carbon Footprint';
  CorrectAnswers[5] := 'a';

  memoResults5.Lines.Clear;

  // Ask questions and collect answers
  for i := 1 to 5 do
  begin
    var
      UserInput: string;
    repeat
      UserInput := LowerCase(InputBox('Question ' + IntToStr(i),
        Questions[i] + #13#10 + Options[i, 1] + #13#10 + Options[i, 2] + #13#10
        + Options[i, 3], ''));
    until (UserInput = 'a') or (UserInput = 'b') or (UserInput = 'c');

    UserAnswers[i] := UserInput[1];

    if UserAnswers[i] = CorrectAnswers[i] then
      memoResults5.Lines.Add('Question ' + IntToStr(i) + ': ' + 'Correct')
    else
      memoResults5.Lines.Add('Question ' + IntToStr(i) + ': ' + 'Incorrect');
  end;

  // Tally up total correct answers
  var
    TotalCorrect: integer := 0;
  for i := 1 to 5 do
  begin
    if UserAnswers[i] = CorrectAnswers[i] then
      Inc(TotalCorrect);
  end;
  memoResults5.Lines.Add('');
  memoResults5.Lines.Add('Total Correct Answers: ' + IntToStr(TotalCorrect) +
    ' out of 5');

  // getting event details and posting event details in tblEvents
  CurrentActionDate := now;
  ActionDate := DateTimeToStr(CurrentActionDate);
  dmEC.tblEvents.Append;
  dmEC.tblEvents['UserID'] := frmLoginPage.UserID;
  dmEC.tblEvents['ActionType'] := 'QUIZ';
  dmEC.tblEvents['ActionDate'] := ActionDate;
  dmEC.tblEvents['ActionDescription'] :=
    'Quiz based on various environmenatal aspects plaguing our earth';
  dmEC.tblEvents.post;

  // assigning points for events and posting points upon completion of calculation
  QuizPoints := 50;
  if dmEC.tblUsers.Locate('Username', LoggedInUser, []) then
  begin
    dmEC.tblUsers.Edit; // Start editing the current record
    dmEC.tblUsers.FieldByName('UserPoints').AsInteger :=
      dmEC.tblUsers.FieldByName('UserPoints').AsInteger + QuizPoints;
    dmEC.tblUsers.post; // Save the changes
  end
  else
  begin
    ShowMessage('User not found in the database.');
    Exit;
  end;
end;

procedure TfrmEcoCyberEvents.btnFirstQuizClick(Sender: TObject);
var
  Questions: array [1 .. 5] of string;
  Options: array [1 .. 5, 1 .. 3] of string;
  CorrectAnswers: array [1 .. 5] of Char;
  UserAnswers: array [1 .. 5] of Char;
  i: integer;
  ActionDate: string;
  CurrentActionDate: Tdate;
  QuizPoints: integer;
begin
  // Set up questions, options, and correct answers
  Questions[1] :=
    'What is the primary greenhouse gas responsible for global warming?';
  Options[1, 1] := 'a) Carbon Dioxide';
  Options[1, 2] := 'b) Oxygen';
  Options[1, 3] := 'c) Nitrogen';
  CorrectAnswers[1] := 'a';

  Questions[2] :=
    'Which activity contributes the most to deforestation and carbon emissions?';
  Options[2, 1] := 'a) Industrial Pollution';
  Options[2, 2] := 'b) Logging';
  Options[2, 3] := 'c) Recycling';
  CorrectAnswers[2] := 'b';

  Questions[3] :=
    'What is a common renewable energy source used to combat climate change?';
  Options[3, 1] := 'a) Coal';
  Options[3, 2] := 'b) Oil';
  Options[3, 3] := 'c) Solar';
  CorrectAnswers[3] := 'c';

  Questions[4] :=
    'What is the term for the gradual rise in Earth''s average temperature?';
  Options[4, 1] := 'a) Global Warming';
  Options[4, 2] := 'b) Climate Cooling';
  Options[4, 3] := 'c) Weather Fluctuation';
  CorrectAnswers[4] := 'a';

  Questions[5] :=
    'Which is a consequence of melting polar ice caps due to climate change?';
  Options[5, 1] := 'a) Increased Water Scarcity';
  Options[5, 2] := 'b) Rising Sea Levels';
  Options[5, 3] := 'c) Decreased Rainfall';
  CorrectAnswers[5] := 'b';

  memoResults.Lines.Clear;

  // Ask questions and collect answers
  for i := 1 to 5 do
  begin
    var
      UserInput: string;
    repeat
      UserInput := LowerCase(InputBox('Question ' + IntToStr(i),
        Questions[i] + #13#10 + Options[i, 1] + #13#10 + Options[i, 2] + #13#10
        + Options[i, 3], ''));
    until (UserInput = 'a') or (UserInput = 'b') or (UserInput = 'c');

    UserAnswers[i] := UserInput[1];

    if UserAnswers[i] = CorrectAnswers[i] then
      memoResults.Lines.Add('Question ' + IntToStr(i) + ': ' + 'Correct')
    else
      memoResults.Lines.Add('Question ' + IntToStr(i) + ': ' + 'Incorrect');
  end;

  // Tally up total correct answers
  var
    TotalCorrect: integer := 0;
  for i := 1 to 5 do
  begin
    if UserAnswers[i] = CorrectAnswers[i] then
      Inc(TotalCorrect);
  end;

  memoResults.Lines.Add('');
  memoResults.Lines.Add('Total Correct Answers: ' + IntToStr(TotalCorrect) +
    ' out of 5');

  // getting event details and posting event details in tblEvents
  CurrentActionDate := now;
  ActionDate := DateTimeToStr(CurrentActionDate);
  dmEC.tblEvents.Append;
  dmEC.tblEvents['UserID'] := frmLoginPage.UserID;
  dmEC.tblEvents['ActionType'] := 'QUIZ';
  dmEC.tblEvents['ActionDate'] := ActionDate;
  dmEC.tblEvents['ActionDescription'] :=
    'Quiz based on various environmenatal aspects plaguing our earth';
  dmEC.tblEvents.post;

  // assigning points for events and posting points upon completion of calculation
  QuizPoints := 100;
  if dmEC.tblUsers.Locate('Username', LoggedInUser, []) then
  begin
    dmEC.tblUsers.Edit; // Start editing the current record
    dmEC.tblUsers.FieldByName('UserPoints').AsInteger :=
      dmEC.tblUsers.FieldByName('UserPoints').AsInteger + QuizPoints;
    dmEC.tblUsers.post; // Save the changes
  end
  else
  begin
    ShowMessage('User not found in the database.');
    Exit;
  end;
end;

procedure TfrmEcoCyberEvents.btnFourthQuizClick(Sender: TObject);
var
  Questions: array [1 .. 5] of string;
  Options: array [1 .. 5, 1 .. 3] of string;
  CorrectAnswers: array [1 .. 5] of Char;
  UserAnswers: array [1 .. 5] of Char;
  i: integer;
  ActionDate: string;
  CurrentActionDate: Tdate;
  QuizPoints: integer;
begin
  // Set up questions, options, and correct answers
  Questions[1] :=
    'What is the term for the process by which Earth''s atmosphere traps heat and keeps the planet warm?';
  Options[1, 1] := 'a) Ozone Depletion';
  Options[1, 2] := 'b) Greenhouse Effect';
  Options[1, 3] := 'c) Carbon Sequestration';
  CorrectAnswers[1] := 'b';

  Questions[2] :=
    'Which is a major source of methane emissions contributing to climate change?';
  Options[2, 1] := 'a) Deforestation';
  Options[2, 2] := 'b) Industrial Waste';
  Options[2, 3] := 'c) Livestock Farming';
  CorrectAnswers[2] := 'c';

  Questions[3] :=
    'What term refers to the loss of a glacier''s mass due to melting and sublimation?';
  Options[3, 1] := 'a) Glacial Erosion';
  Options[3, 2] := 'b) Glacial Retreat';
  Options[3, 3] := 'c) Glacial Endowment';
  CorrectAnswers[3] := 'b';

  Questions[4] :=
    'Which international agreement aims to limit global warming by reducing greenhouse gas emissions?';
  Options[4, 1] := 'a) Montreal Protocol';
  Options[4, 2] := 'b) Kyoto Protocol';
  Options[4, 3] := 'c) Paris Agreement';
  CorrectAnswers[4] := 'c';

  Questions[5] :=
    'What term describes the irreversible collapse of a marine ecosystem due to environmental stressors?';
  Options[5, 1] := 'a) Eutrophication';
  Options[5, 2] := 'b) Coral Bleaching';
  Options[5, 3] := 'c) Ocean Acidification';
  CorrectAnswers[5] := 'b';

  memoResults4.Lines.Clear;

  // Ask questions and collect answers
  for i := 1 to 5 do
  begin
    var
      UserInput: string;
    repeat
      UserInput := LowerCase(InputBox('Question ' + IntToStr(i),
        Questions[i] + #13#10 + Options[i, 1] + #13#10 + Options[i, 2] + #13#10
        + Options[i, 3], ''));
    until (UserInput = 'a') or (UserInput = 'b') or (UserInput = 'c');

    UserAnswers[i] := UserInput[1];

    if UserAnswers[i] = CorrectAnswers[i] then
      memoResults4.Lines.Add('Question ' + IntToStr(i) + ': ' + 'Correct')
    else
      memoResults4.Lines.Add('Question ' + IntToStr(i) + ': ' + 'Incorrect');
  end;

  // Tally up total correct answers
  var
    TotalCorrect: integer := 0;
  for i := 1 to 5 do
  begin
    if UserAnswers[i] = CorrectAnswers[i] then
      Inc(TotalCorrect);
  end;

  memoResults4.Lines.Add('');
  memoResults4.Lines.Add('Total Correct Answers: ' + IntToStr(TotalCorrect) +
    ' out of 5');

  // getting event details and posting event details in tblEvents
  CurrentActionDate := now;
  ActionDate := DateTimeToStr(CurrentActionDate);
  dmEC.tblEvents.Append;
  dmEC.tblEvents['UserID'] := frmLoginPage.UserID;
  dmEC.tblEvents['ActionType'] := 'QUIZ';
  dmEC.tblEvents['ActionDate'] := ActionDate;
  dmEC.tblEvents['ActionDescription'] :=
    'Quiz based on various environmenatal aspects plaguing our earth';
  dmEC.tblEvents.post;

  // assigning points for events and posting points upon completion of calculation
  QuizPoints := 25;
  if dmEC.tblUsers.Locate('Username', LoggedInUser, []) then
  begin
    dmEC.tblUsers.Edit; // Start editing the current record
    dmEC.tblUsers.FieldByName('UserPoints').AsInteger :=
      dmEC.tblUsers.FieldByName('UserPoints').AsInteger + QuizPoints;
    dmEC.tblUsers.post; // Save the changes
  end
  else
  begin
    ShowMessage('User not found in the database.');
    Exit;
  end;

end;

procedure TfrmEcoCyberEvents.btnPlayClick(Sender: TObject);
var
  CurrentActionDate: Tdate;
  ActionDate: string;
  VideoPoints: integer;
begin
  WindowsMediaPlayer1.URL := 'GlobalWarmingFrom1880to2022.mp4';
  WindowsMediaPlayer1.Controls.play;

  if WindowsMediaPlayer1.playState = 8 then
  begin
    ShowMessage('You finished watching the video!');
    btnWatchVid1.Enabled := false;
    // getting event details and posting event details in tblEvents
    CurrentActionDate := now;
    ActionDate := DateTimeToStr(CurrentActionDate);
    dmEC.tblEvents.Append;
    dmEC.tblEvents['UserID'] := frmLoginPage.UserID;
    dmEC.tblEvents['ActionType'] := 'Video';
    dmEC.tblEvents['ActionDate'] := ActionDate;
    dmEC.tblEvents['ActionDescription'] :=
      'video of Global Warming From 1880 to 2022';
    dmEC.tblEvents.post;

    // assigning points for events and posting points upon completion of calculation
    VideoPoints := 150;
    if dmEC.tblUsers.Locate('Username', LoggedInUser, []) then
    begin
      dmEC.tblUsers.Edit; // Start editing the current record
      dmEC.tblUsers.FieldByName('UserPoints').AsInteger :=
        dmEC.tblUsers.FieldByName('UserPoints').AsInteger + VideoPoints;
      dmEC.tblUsers.post; // Save the changes
    end
    else
    begin
      ShowMessage('User not found in the database.');
      Exit;
    end;
  end;

end;

procedure TfrmEcoCyberEvents.btnPlayVid2Click(Sender: TObject);
var
  CurrentActionDate: Tdate;
  ActionDate: string;
  VideoPoints: integer;
begin
  WindowsMediaPlayer2.URL := 'HDviewofcarbondioxide.mp4';
  WindowsMediaPlayer2.Controls.play;

  if WindowsMediaPlayer2.playState = 8 then
  begin
    ShowMessage('You finished watching the video!');
    btnWatchVid2.Enabled := false;

    // getting event details and posting event details in tblEvents
    CurrentActionDate := now;
    ActionDate := DateTimeToStr(CurrentActionDate);
    dmEC.tblEvents.Append;
    dmEC.tblEvents['UserID'] := frmLoginPage.UserID;
    dmEC.tblEvents['ActionType'] := 'Video';
    dmEC.tblEvents['ActionDate'] := ActionDate;
    dmEC.tblEvents['ActionDescription'] := 'video of HD view of carbon dioxide';
    dmEC.tblEvents.post;

    // assigning points for events and posting points upon completion of calculation
    VideoPoints := 50;
    if dmEC.tblUsers.Locate('Username', LoggedInUser, []) then
    begin
      dmEC.tblUsers.Edit; // Start editing the current record
      dmEC.tblUsers.FieldByName('UserPoints').AsInteger :=
        dmEC.tblUsers.FieldByName('UserPoints').AsInteger + VideoPoints;
      dmEC.tblUsers.post; // Save the changes
    end
    else
    begin
      ShowMessage('User not found in the database.');
      Exit;
    end;
  end;
end;

procedure TfrmEcoCyberEvents.btnPTVCClick(Sender: TObject);

begin
  pnlPTVC.Show;
  pnlPTVC.Align := alClient;
  imgPTPT.Align := alClient;
end;

procedure TfrmEcoCyberEvents.btnQuiz1Click(Sender: TObject);
begin
  pnlQuiz1.Show;
  pnlQuiz1.Align := alClient;
  imgQuiz1.Align := alClient;
end;

procedure TfrmEcoCyberEvents.btnSecondQuizClick(Sender: TObject);
var
  Questions: array [1 .. 5] of string;
  Options: array [1 .. 5, 1 .. 3] of string;
  CorrectAnswers: array [1 .. 5] of Char;
  UserAnswers: array [1 .. 5] of Char;
  i: integer;
  ActionDate: string;
  CurrentActionDate: Tdate;
  QuizPoints: integer;
begin
  // Set up questions, options, and correct answers
  Questions[1] :=
    'Which of the following is a major contributor to air pollution?';
  Options[1, 1] := 'a) Bicycles';
  Options[1, 2] := 'b) Trees';
  Options[1, 3] := 'c) Cars';
  CorrectAnswers[1] := 'c';

  Questions[2] := 'What is the main cause of deforestation?';
  Options[2, 1] := 'a) Planting more trees';
  Options[2, 2] := 'b) Logging';
  Options[2, 3] := 'c) Desertification';
  CorrectAnswers[2] := 'b';

  Questions[3] := 'Which energy source is known to produce radioactive waste?';
  Options[3, 1] := 'a) Wind';
  Options[3, 2] := 'b) Solar';
  Options[3, 3] := 'c) Nuclear';
  CorrectAnswers[3] := 'c';

  Questions[4] :=
    'What is the term for the gradual loss of biodiversity due to human activities?';
  Options[4, 1] := 'a) Bioaccumulation';
  Options[4, 2] := 'b) Extinction';
  Options[4, 3] := 'c) Biodiversity enhancement';
  CorrectAnswers[4] := 'b';

  Questions[5] :=
    'Which environmental issue is associated with the excessive use of plastic?';
  Options[5, 1] := 'a) Soil erosion';
  Options[5, 2] := 'b) Deforestation';
  Options[5, 3] := 'c) Plastic pollution';
  CorrectAnswers[5] := 'c';

  memoResults2.Lines.Clear;

  // Ask questions and collect answers
  for i := 1 to 5 do
  begin
    var
      UserInput: string;
    repeat
      UserInput := LowerCase(InputBox('Question ' + IntToStr(i),
        Questions[i] + #13#10 + Options[i, 1] + #13#10 + Options[i, 2] + #13#10
        + Options[i, 3], ''));
    until (UserInput = 'a') or (UserInput = 'b') or (UserInput = 'c');

    UserAnswers[i] := UserInput[1];

    if UserAnswers[i] = CorrectAnswers[i] then
      memoResults2.Lines.Add('Question ' + IntToStr(i) + ': ' + 'Correct')
    else
      memoResults2.Lines.Add('Question ' + IntToStr(i) + ': ' + 'Incorrect');
  end;

  // Tally up total correct answers
  var
    TotalCorrect: integer := 0;
  for i := 1 to 5 do
  begin
    if UserAnswers[i] = CorrectAnswers[i] then
      Inc(TotalCorrect);
  end;

  memoResults2.Lines.Add('');
  memoResults2.Lines.Add('Total Correct Answers: ' + IntToStr(TotalCorrect) +
    ' out of 5');

  // getting event details and posting event details in tblEvents
  CurrentActionDate := now;
  ActionDate := DateTimeToStr(CurrentActionDate);
  dmEC.tblEvents.Append;
  dmEC.tblEvents['UserID'] := frmLoginPage.UserID;
  dmEC.tblEvents['ActionType'] := 'QUIZ';
  dmEC.tblEvents['ActionDate'] := ActionDate;
  dmEC.tblEvents['ActionDescription'] :=
    'Quiz based on various environmenatal aspects plaguing our earth';
  dmEC.tblEvents.post;
  // assigning points for events and posting points upon completion of calculation
  QuizPoints := 100;
  if dmEC.tblUsers.Locate('Username', LoggedInUser, []) then
  begin
    dmEC.tblUsers.Edit; // Start editing the current record
    dmEC.tblUsers.FieldByName('UserPoints').AsInteger :=
      dmEC.tblUsers.FieldByName('UserPoints').AsInteger + QuizPoints;
    dmEC.tblUsers.post; // Save the changes
  end
  else
  begin
    ShowMessage('User not found in the database.');
    Exit;
  end;
end;

procedure TfrmEcoCyberEvents.btnThirdQuizClick(Sender: TObject);
var
  Questions: array [1 .. 5] of string;
  Options: array [1 .. 5, 1 .. 3] of string;
  CorrectAnswers: array [1 .. 5] of Char;
  UserAnswers: array [1 .. 5] of Char;
  i: integer;
  ActionDate: string;
  CurrentActionDate: Tdate;
  QuizPoints: integer;
begin
  // Set up questions, options, and correct answers
  Questions[1] :=
    'Which type of pollution is caused by excessive noise that disrupts the environment?';
  Options[1, 1] := 'a) Air Pollution';
  Options[1, 2] := 'b) Water Pollution';
  Options[1, 3] := 'c) Noise Pollution';
  CorrectAnswers[1] := 'c';

  Questions[2] :=
    'What type of pollution results from the release of harmful substances into the air?';
  Options[2, 1] := 'a) Noise Pollution';
  Options[2, 2] := 'b) Light Pollution';
  Options[2, 3] := 'c) Air Pollution';
  CorrectAnswers[2] := 'c';

  Questions[3] :=
    'Which type of pollution affects bodies of water like rivers, lakes, and oceans?';
  Options[3, 1] := 'a) Soil Pollution';
  Options[3, 2] := 'b) Air Pollution';
  Options[3, 3] := 'c) Water Pollution';
  CorrectAnswers[3] := 'c';

  Questions[4] :=
    'What is the term for pollution that comes from sources like factories and vehicles?';
  Options[4, 1] := 'a) Industrial Pollution';
  Options[4, 2] := 'b) Agricultural Pollution';
  Options[4, 3] := 'c) Noise Pollution';
  CorrectAnswers[4] := 'a';

  Questions[5] :=
    'What type of pollution occurs when light from urban areas interferes with the night sky?';
  Options[5, 1] := 'a) Air Pollution';
  Options[5, 2] := 'b) Thermal Pollution';
  Options[5, 3] := 'c) Light Pollution';
  CorrectAnswers[5] := 'c';

  memoResults3.Lines.Clear;

  // Ask questions and collect answers
  for i := 1 to 5 do
  begin
    var
      UserInput: string;
    repeat
      UserInput := LowerCase(InputBox('Question ' + IntToStr(i),
        Questions[i] + #13#10 + Options[i, 1] + #13#10 + Options[i, 2] + #13#10
        + Options[i, 3], ''));
    until (UserInput = 'a') or (UserInput = 'b') or (UserInput = 'c');

    UserAnswers[i] := UserInput[1];

    if UserAnswers[i] = CorrectAnswers[i] then
      memoResults3.Lines.Add('Question ' + IntToStr(i) + ': ' + 'Correct')
    else
      memoResults3.Lines.Add('Question ' + IntToStr(i) + ': ' + 'Incorrect');
  end;

  // Tally up total correct answers
  var
    TotalCorrect: integer := 0;
  for i := 1 to 5 do
  begin
    if UserAnswers[i] = CorrectAnswers[i] then
      Inc(TotalCorrect);
  end;

  memoResults3.Lines.Add('');
  memoResults3.Lines.Add('Total Correct Answers: ' + IntToStr(TotalCorrect) +
    ' out of 5');
  // getting event details and posting event details in tblEvents
  CurrentActionDate := now;
  ActionDate := DateTimeToStr(CurrentActionDate);
  dmEC.tblEvents.Append;
  dmEC.tblEvents['UserID'] := frmLoginPage.UserID;
  dmEC.tblEvents['ActionType'] := 'QUIZ';
  dmEC.tblEvents['ActionDate'] := ActionDate;
  dmEC.tblEvents['ActionDescription'] :=
    'Quiz based on various environmenatal aspects plaguing our earth';
  dmEC.tblEvents.post;

  // assigning points for events and posting points upon completion of calculation
  QuizPoints := 75;
  if dmEC.tblUsers.Locate('Username', LoggedInUser, []) then
  begin
    dmEC.tblUsers.Edit; // Start editing the current record
    dmEC.tblUsers.FieldByName('UserPoints').AsInteger :=
      dmEC.tblUsers.FieldByName('UserPoints').AsInteger + QuizPoints;
    dmEC.tblUsers.post; // Save the changes
  end
  else
  begin
    ShowMessage('User not found in the database.');
    Exit;
  end;
end;

procedure TfrmEcoCyberEvents.btnWatchVid1Click(Sender: TObject);
begin
  // showing panel and aligning of panel and image on click
  pnlCCV1.Show;
  pnlCCV1.Align := alClient;
  imgVGW.Align := alClient;

end;

procedure TfrmEcoCyberEvents.btnWatchVid2Click(Sender: TObject);
begin
  // showing panel and aligning of panel and image on click
  pnlCCV2.Show;
  pnlCCV2.Align := alClient;
  imgCCV2ui.Align := alClient;

end;

procedure TfrmEcoCyberEvents.ButtonSubmitClick(Sender: TObject);
var
  i: integer;
  CurrentActionDate: Tdate;
  ActionDate: string;
  PledgePoints : integer;
begin
  MemoPledges.Lines.Clear;

  // Loop through the checkboxes and update pledges
  SetLength(Pledges, CheckListPledges.Count);
  for i := 0 to CheckListPledges.Count - 1 do
  begin
    Pledges[i] := CheckListPledges.Items[i];
    if CheckListPledges.Checked[i] then
      MemoPledges.Lines.Add('Pledged: ' + Pledges[i]);
  end;

  // Display thank you message
  MemoPledges.Lines.Add('');
  MemoPledges.Lines.Add
    ('Thank you for pledging to reduce your carbon footprint!');

  // getting current date of action
  CurrentActionDate := now;
  ActionDate := DateTimeToStr(CurrentActionDate);
  // posting event actions in tblEvents under userID of logged in user
  dmEC.tblEvents.Append;
  dmEC.tblEvents['UserID'] := frmLoginPage.UserID;
  dmEC.tblEvents['ActionType'] := 'Pledging To Change';
  dmEC.tblEvents['ActionDate'] := ActionDate;
  dmEC.tblEvents['ActionDescription'] :=
    'Pledged to do more eco friendly things to be a part of a small increment to create a greater change';
  dmEC.tblEvents.post;
   //assigning points for events and posting points upon completion of calculation
  PledgePoints := 100;
  if dmEC.tblUsers.Locate('Username', LoggedInUser, []) then
  begin
    dmEC.tblUsers.Edit; // Start editing the current record
    dmEC.tblUsers.FieldByName('UserPoints').AsInteger :=
      dmEC.tblUsers.FieldByName('UserPoints').AsInteger + PledgePoints;
    dmEC.tblUsers.post; // Save the changes
  end
  else
  begin
    ShowMessage('User not found in the database.');
    Exit;
  end;
end;

procedure TfrmEcoCyberEvents.FormCreate(Sender: TObject);
begin

  // setting a fixed form width and height
  frmEcoCyberEvents.Width := 1350;
  frmEcoCyberEvents.Height := 767;
  frmEcoCyberEvents.ClientHeight := 767;
  frmEcoCyberEvents.ClientWidth := 1350;

end;

procedure TfrmEcoCyberEvents.imgReturnAECpnlClick(Sender: TObject);
begin
  // hiding panel to reveal main events page
  pnLAEC.Hide;
end;

procedure TfrmEcoCyberEvents.imgReturnGCDVpnlClick(Sender: TObject);
begin
  pnlCCV2.Hide;
end;

procedure TfrmEcoCyberEvents.imgReturnECEtoHomePageClick(Sender: TObject);
begin
  // closing form and showing home page
  frmEcoCyberEvents.Close;
  frmHomePage.Show;

end;

procedure TfrmEcoCyberEvents.imgReturnPTPTpnlClick(Sender: TObject);
begin
  // hiding panel to reveal main events page
  pnlPTVC.Hide;
end;

procedure TfrmEcoCyberEvents.imgReturnQuiz1Click(Sender: TObject);
begin
  // hiding panel to reveal main events page
  pnlQuiz1.Hide;
end;

procedure TfrmEcoCyberEvents.imgReturnCPOFpnlClick(Sender: TObject);
begin
  // hiding panel to reveal main events page
  pnlCRP.Hide;
end;

procedure TfrmEcoCyberEvents.imgReturnGWVpnlClick(Sender: TObject);
begin
  // hiding panel to reveal main events page
  pnlCCV1.Hide;
end;

end.
