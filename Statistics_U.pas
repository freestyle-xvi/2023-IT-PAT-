unit Statistics_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ComCtrls;

type
  TfrmStatsPage = class(TForm)
    imgBack: TImage;
    imgBG: TImage;
    btnInfographic1: TButton;
    imgInfographic1: TImage;
    pnlinfographic1: TPanel;
    imgReturn: TImage;
    pnlC02Graph: TPanel;
    imgCO2graph: TImage;
    Image2: TImage;
    btnCO2Graph: TButton;
    pnlLandOceanTempIndexNasa: TPanel;
    imgLandTempIndexUI: TImage;
    Image3: TImage;
    btnLandOceanTempIndex: TButton;
    btnVisualize: TButton;
    memLOTI: TMemo;
    reditExplanation: TRichEdit;
    RichEdit1: TRichEdit;
    pnlGlobalTempGraph: TPanel;
    imgGlobalTempGraph: TImage;
    Image5: TImage;
    lbltitle: TLabel;
    btnGlobalTempGraph: TButton;
    pnlGGS: TPanel;
    imgPuffer: TImage;
    Image6: TImage;
    btnInfographic2: TButton;
    btnCoffeeInfographic: TButton;
    pnlCoffee: TPanel;
    imgCoffee: TImage;
    Image1: TImage;
    btnIPCC: TButton;
    pnlIPCC: TPanel;
    imgIPCC: TImage;
    Image4: TImage;
    btnFacts: TButton;
    pnlFacts: TPanel;
    imgFactsUI: TImage;
    Image8: TImage;
    btnShowFacts: TButton;
    memoFacts: TMemo;
    lblTitleFactsPage: TLabel;
    procedure imgBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInfographic1Click(Sender: TObject);
    procedure imgReturnClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure btnCO2GraphClick(Sender: TObject);
    procedure btnVisualizeClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure btnLandOceanTempIndexClick(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure btnGlobalTempGraphClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure btnInfographic2Click(Sender: TObject);
    procedure btnCoffeeInfographicClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure btnIPCCClick(Sender: TObject);
    procedure btnShowFactsClick(Sender: TObject);
    procedure btnFactsClick(Sender: TObject);
    procedure Image8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStatsPage: TfrmStatsPage;

implementation

uses frmHomePage_U;

{$R *.dfm}

procedure TfrmStatsPage.btnCO2GraphClick(Sender: TObject);
begin
  // aligning and showing relevant panel
  pnlC02Graph.Show;
  pnlC02Graph.Align := alClient;
  imgCO2graph.Align := alClient;
end;

procedure TfrmStatsPage.btnCoffeeInfographicClick(Sender: TObject);
begin
  // aligning and showing relevant panel
  pnlCoffee.Align := alClient;
  pnlCoffee.Show;
  imgCoffee.Align := alClient;

end;

procedure TfrmStatsPage.btnFactsClick(Sender: TObject);
begin
  // aligning and showing relevant panel
  pnlFacts.Show;
  pnlFacts.Align := alClient;
  imgFactsUI.Align := alClient;
end;

procedure TfrmStatsPage.btnGlobalTempGraphClick(Sender: TObject);
begin
  // aligning and showing relevant panel
  pnlGlobalTempGraph.Align := alClient;
  pnlGlobalTempGraph.Show;
  imgGlobalTempGraph.Align := alClient;
end;

procedure TfrmStatsPage.btnInfographic1Click(Sender: TObject);
begin
  // aligning and showing relevant panel
  pnlinfographic1.Align := alClient;
  pnlinfographic1.Show;
  imgInfographic1.Align := alClient;
end;

procedure TfrmStatsPage.btnInfographic2Click(Sender: TObject);
begin
  // aligning and showing relevant panel
  pnlGGS.Align := alClient;
  pnlGGS.Show;
  imgPuffer.Align := alClient;
end;

procedure TfrmStatsPage.btnIPCCClick(Sender: TObject);
begin
  // aligning and showing relevant panel
  pnlIPCC.Show;
  pnlIPCC.Align := alClient;;
  imgIPCC.Align := alClient;
end;

procedure TfrmStatsPage.btnLandOceanTempIndexClick(Sender: TObject);
begin

  // aligning and showing relevant panel
  pnlLandOceanTempIndexNasa.Align := alClient;
  pnlLandOceanTempIndexNasa.Show;
  imgLandTempIndexUI.Align := alClient;

end;

procedure TfrmStatsPage.btnShowFactsClick(Sender: TObject);
var
  FactFile: TextFile;
  FactLine: string;
begin
  // Clear existing content in the memo box and making the memobox a scrollable component
  memoFacts.Lines.Clear;


  // Open the "Facts.txt" text file
  AssignFile(FactFile, 'Facts.txt');
  try
    Reset(FactFile);

    // Read and add each fact from the text file to the memo box
    while not EOF(FactFile) do
    begin
      ReadLn(FactFile, FactLine);
      memoFacts.Lines.Add(FactLine);
    end;

    // Close the text file
    CloseFile(FactFile);

    // Position the memo box at the top
    memoFacts.SelStart := 0;
    memoFacts.SelLength := 0;

    // Make the memo box read-only
    memoFacts.ReadOnly := True;
  except
    on E: Exception do
      ShowMessage('Error loading facts: ' + E.Message);
  end;

end;

procedure TfrmStatsPage.btnVisualizeClick(Sender: TObject);
var
  TextLines: TStringList;
begin
  // Initialize the TStringList to store the lines from the text file
  TextLines := TStringList.Create;

  try
    // Load the contents of the text file into the TStringList
    TextLines.LoadFromFile('LOTI.txt'); // file path

    // Clear the memo box and add the heading with adjusted column spacing
    memLOTI.Clear;
    memLOTI.Lines.Add(Format('%-8s %-18s %-18s',
      ['    Year', '     Temperature', 'Temperature']));

    // Add the formatted data with adjusted column spacing and font size
    for var i := 0 to TextLines.Count - 1 do
    begin
      if TextLines[i].Trim <> '' then // Skip empty lines
      begin
        var
          Values: TArray<string> := TextLines[i].Split([' ']);
        if Length(Values) >= 3 then
        begin
          // Add formatted line with adjusted spacing
          memLOTI.Lines.Add(Format('%-15s %-15s %-15s', [Values[0], Values[1],
            Values[2]]));

          // Adjust the font size
          memLOTI.Font.Size := 25; // Increase or decrease as needed
        end;
      end;
    end;

    // Scroll the memo box to the top
    memLOTI.Perform(EM_SCROLL, SB_TOP, 0);

  finally
    // Free the TStringList to release memory
    TextLines.Free;
  end;

end;

procedure TfrmStatsPage.FormCreate(Sender: TObject);
begin

  // setting a fixed form width and height
  frmStatsPage.Width := 1360;
  frmStatsPage.Height := 777;
  frmStatsPage.ClientHeight := 777;
  frmStatsPage.ClientWidth := 1360;

  // hiding all panels on create
  pnlinfographic1.Hide;
  pnlC02Graph.Hide;
  pnlLandOceanTempIndexNasa.Hide;
  pnlLandOceanTempIndexNasa.Hide;
  pnlGlobalTempGraph.Hide;
  pnlGGS.Hide;
  pnlCoffee.Hide;
  pnlIPCC.Hide;
  pnlFacts.Hide;

end;

procedure TfrmStatsPage.Image1Click(Sender: TObject);
begin
  pnlCoffee.Hide;
end;

procedure TfrmStatsPage.Image2Click(Sender: TObject);
begin
  pnlC02Graph.Hide;
end;

procedure TfrmStatsPage.Image3Click(Sender: TObject);
begin
  pnlLandOceanTempIndexNasa.Hide;
end;

procedure TfrmStatsPage.Image4Click(Sender: TObject);
begin
  pnlIPCC.Hide;
end;

procedure TfrmStatsPage.Image5Click(Sender: TObject);
begin
  pnlGlobalTempGraph.Hide;
end;

procedure TfrmStatsPage.Image6Click(Sender: TObject);
begin
  pnlGGS.Hide;
end;

procedure TfrmStatsPage.Image8Click(Sender: TObject);
begin
  pnlFacts.Hide;
end;

procedure TfrmStatsPage.imgBackClick(Sender: TObject);
begin
  frmStatsPage.close;
  frmHomePage.Show;
end;

procedure TfrmStatsPage.imgReturnClick(Sender: TObject);
begin
  pnlinfographic1.Hide;
end;

end.
