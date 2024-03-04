program saveThePlanetXVI_P;

uses
  Vcl.Forms,
  frmSaveThePlanetXVI_U in 'frmSaveThePlanetXVI_U.pas' {frmStartupPage},
  frmLoginPage_U in 'frmLoginPage_U.pas' {frmLoginPage},
  SignUpPage_U in 'SignUpPage_U.pas' {frmSignUpPage},
  frmHomePage_U in 'frmHomePage_U.pas' {frmHomePage},
  frmDataModuleEcoCyber_U in 'frmDataModuleEcoCyber_U.pas' {dmEC: TDataModule},
  frmAdminDashboard_U in 'frmAdminDashboard_U.pas' {frmAdminDashboard},
  frmLoadingScreen_U in 'frmLoadingScreen_U.pas' {frmLoadingScreen},
  frmModeratorDashboard_U in 'frmModeratorDashboard_U.pas' {frmModeratorDashboard},
  EditUserDetails_U in 'EditUserDetails_U.pas' {frmEditDetails},
  Statistics_U in 'Statistics_U.pas' {frmStatsPage},
  EcoCyberEvents_U in 'EcoCyberEvents_U.pas' {frmEcoCyberEvents},
  EcoCyberNews_U in 'EcoCyberNews_U.pas' {frmNews},
  EcoCyberLearnMore_U in 'EcoCyberLearnMore_U.pas' {frmLearnMore},
  EcoCyberStore_U in 'EcoCyberStore_U.pas' {frmEcoCyberStore},
  AdminCodeManager in 'AdminCodeManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmStartupPage, frmStartupPage);
  Application.CreateForm(TfrmLoginPage, frmLoginPage);
  Application.CreateForm(TfrmSignUpPage, frmSignUpPage);
  Application.CreateForm(TfrmHomePage, frmHomePage);
  Application.CreateForm(TdmEC, dmEC);
  Application.CreateForm(TfrmAdminDashboard, frmAdminDashboard);
  Application.CreateForm(TfrmLoadingScreen, frmLoadingScreen);
  Application.CreateForm(TfrmModeratorDashboard, frmModeratorDashboard);
  Application.CreateForm(TfrmEditDetails, frmEditDetails);
  Application.CreateForm(TfrmStatsPage, frmStatsPage);
  Application.CreateForm(TfrmEcoCyberEvents, frmEcoCyberEvents);
  Application.CreateForm(TfrmNews, frmNews);
  Application.CreateForm(TfrmLearnMore, frmLearnMore);
  Application.CreateForm(TfrmEcoCyberStore, frmEcoCyberStore);
  Application.Run;
end.
