unit EcoCyberNews_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw;

type
  TfrmNews = class(TForm)
    WebBrowser1: TWebBrowser;
    Image1: TImage;
    btnA1: TButton;
    btnA2: TButton;
    btnA3: TButton;
    btnA4: TButton;
    btnA5: TButton;
    imgNewsUI: TImage;
    procedure btnA1Click(Sender: TObject);
    procedure btnA2Click(Sender: TObject);
    procedure btnA3Click(Sender: TObject);
    procedure btnA4Click(Sender: TObject);
    procedure btnA5Click(Sender: TObject);
    procedure imgNewsUIClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNews: TfrmNews;

implementation


uses frmHomePage_U;
{$R *.dfm}

procedure TfrmNews.btnA1Click(Sender: TObject);
begin
  // Load a local PDF file
  WebBrowser1.Navigate
    ('C:\Users\DELL\Pictures\PAT\Program\Resources\ClimateChangePolicyBrief.pdf');
end;

procedure TfrmNews.btnA2Click(Sender: TObject);
begin
  // Load a local PDF file
  WebBrowser1.Navigate('C:\Users\DELL\Pictures\PAT\Program\Resources\ClimateChange.pdf');
end;

procedure TfrmNews.btnA3Click(Sender: TObject);
begin
  // Load a local PDF file
  WebBrowser1.Navigate
    ('C:\Users\DELL\Pictures\PAT\Program\Resources\fastfacts-what-is-climate-change.pdf');
end;

procedure TfrmNews.btnA4Click(Sender: TObject);
begin
  // Load a local PDF file
  WebBrowser1.Navigate
    ('C:\Users\DELL\Pictures\PAT\Program\Resources\FP_20230301_climate_energy_2023_gross.pdf');
end;

procedure TfrmNews.btnA5Click(Sender: TObject);
begin
  // Load a local PDF file
  WebBrowser1.Navigate
    ('C:\Users\DELL\Pictures\PAT\Program\Resources\IPCC_AR6_SYR_SPM.pdf');
end;

procedure TfrmNews.imgNewsUIClick(Sender: TObject);
begin
frmNews.Close;
frmHomePage.show;
end;

end.
