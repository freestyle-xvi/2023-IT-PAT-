unit AdminCodeManager;

interface

type
  TAdminCodeManager = class
  private
    FAdminDigits: Integer;

    function GenerateRandomCode: Integer;
    procedure WriteCodeToFile(code: Integer);
    function SearchCodeInFile(code: Integer): Boolean;

  public
    constructor Create;
    function GenerateAndSaveCode: Integer;
    function IsCodeValid(codeToCheck: Integer): Boolean;
  end;

implementation

uses
  SysUtils;

constructor TAdminCodeManager.Create;
begin
  inherited;
  Randomize;
end;

function TAdminCodeManager.GenerateRandomCode: Integer;
begin
  Result := Random(9000) + 1000; // Generates a random code between 1000 and 9999
end;

procedure TAdminCodeManager.WriteCodeToFile(code: Integer);
var
  CodeFile: TextFile;
begin
  AssignFile(CodeFile, 'AdminCodes.txt');
  try
    Append(CodeFile);
    Writeln(CodeFile, IntToStr(code));
  finally
    CloseFile(CodeFile);
  end;
end;

function TAdminCodeManager.SearchCodeInFile(code: Integer): Boolean;
var
  CodeFile: TextFile;
  line: string;
begin
  Result := False;
  AssignFile(CodeFile, 'AdminCodes.txt');
  try
    Reset(CodeFile);
    while not Eof(CodeFile) do
    begin
      Readln(CodeFile, line);
      if StrToIntDef(line, -1) = code then
      begin
        Result := True;
        Break;
      end;
    end;
  finally
    CloseFile(CodeFile);
  end;
end;

function TAdminCodeManager.GenerateAndSaveCode: Integer;
begin
  FAdminDigits := GenerateRandomCode;
  WriteCodeToFile(FAdminDigits);
  Result := FAdminDigits;
end;

function TAdminCodeManager.IsCodeValid(codeToCheck: Integer): Boolean;
begin
  Result := SearchCodeInFile(codeToCheck);
end;

end.

