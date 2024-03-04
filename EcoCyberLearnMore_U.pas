unit EcoCyberLearnMore_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, ShellAPI;

type
  TfrmLearnMore = class(TForm)
    imgLearnMoreUI: TImage;
    lblLearnMoreTitle: TLabel;
    lblECLM1: TLabel;
    lblECLM2: TLabel;
    lblECLM3: TLabel;
    lblECLM4: TLabel;
    lblECLM5: TLabel;
    lblECLM6: TLabel;
    lblECLM7: TLabel;
    lblECLM8: TLabel;
    lblECLM9: TLabel;
    lblECLM10: TLabel;
    imgReturnLearnMore: TImage;
    procedure FormCreate(Sender: TObject);
    procedure imgReturnLearnMoreClick(Sender: TObject);
    procedure lblECLM6Click(Sender: TObject);
    procedure lblECLM5Click(Sender: TObject);
    procedure lblECLM10Click(Sender: TObject);
    procedure lblECLM4Click(Sender: TObject);
    procedure lblECLM1Click(Sender: TObject);
    procedure lblECLM8Click(Sender: TObject);
    procedure lblECLM2Click(Sender: TObject);
    procedure lblECLM3Click(Sender: TObject);
    procedure lblECLM7Click(Sender: TObject);
    procedure lblECLM9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLearnMore: TfrmLearnMore;

implementation

uses frmHomePage_U;

{$R *.dfm}

procedure TfrmLearnMore.FormCreate(Sender: TObject);
begin
  frmLearnMore.Left := (Screen.Width - frmLearnMore.Width) div 2;
  frmLearnMore.Top := (Screen.Height - frmLearnMore.Height) div 2;
end;

procedure TfrmLearnMore.imgReturnLearnMoreClick(Sender: TObject);
begin
  frmLearnMore.Close;
  frmHomePage.Show;
end;

procedure TfrmLearnMore.lblECLM10Click(Sender: TObject);
begin
  ShellExecute(0, 'open',
    'https://www.usgs.gov/faqs/what-difference-between-global-warming-and-climate-change',
    nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLearnMore.lblECLM1Click(Sender: TObject);
begin
  try
    ShellExecute(0, 'open',
      'https://climateknowledgeportal.worldbank.org/overview#:~:text=Climate%20change%20is%20the%20significant,change%20from%20natural%20weather%20variability.',
      nil, nil, SW_SHOWNORMAL);
  except
    on E: Exception do
      ShowMessage('Error opening link: ' + E.Message);
  end;
end;

procedure TfrmLearnMore.lblECLM2Click(Sender: TObject);
begin
  ShellExecute(0, 'open',
    'https://www.noaa.gov/education/resource-collections/climate/climate-change-impacts',
    nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLearnMore.lblECLM3Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://climate.nasa.gov/evidence/', nil, nil,
    SW_SHOWNORMAL);
end;

procedure TfrmLearnMore.lblECLM4Click(Sender: TObject);
begin
  ShellExecute(0, 'open',
    'https://royalsociety.org/topics-policy/projects/climate-change-evidence-causes/basics-of-climate-change/',
    nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLearnMore.lblECLM5Click(Sender: TObject);
begin
  ShellExecute(0, 'open',
    'https://www.usaid.gov/climate/country-profiles/south-africa#:~:text=Since%201990%2C%20the%20national%20average,in%20parts%20of%20the%20country.',
    nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLearnMore.lblECLM6Click(Sender: TObject);
begin
  ShellExecute(0, 'open',
    'https://cer.org.za/news/if-we-dont-act-now-on-climate-change-this-is-what-life-in-south-africa-will-look-like',
    nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLearnMore.lblECLM7Click(Sender: TObject);
begin
  ShellExecute(0, 'open',
    'https://www.westerncape.gov.za/general-publication/climate-change', nil,
    nil, SW_SHOWNORMAL);
end;

procedure TfrmLearnMore.lblECLM8Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://oceanservice.noaa.gov/ocean/earthday.html',
    nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLearnMore.lblECLM9Click(Sender: TObject);
begin
  ShellExecute(0, 'open',
    'https://www.sierraclub.org/toiyabe/100-things-you-can-do-save-planet', nil,
    nil, SW_SHOWNORMAL);
end;

end.

