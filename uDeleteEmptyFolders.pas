unit uDeleteEmptyFolders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, ShellAPI, StrUtils, ComCtrls;

const
  cAppTitle = 'Delete Empty Folders';
  cAppRegistryRoot = 'Software\JGhost\DeleteEmptyFolders\';

type
  TfmDeleteEmptyFolders = class(TForm)
    Panel2: TPanel;
    lblCaption: TLabel;
    Label1: TLabel;
    btnStart: TButton;
    edtPath: TEdit;
    logtext: TRichEdit;
    procedure edtPathButtonClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Processing: Boolean;

    procedure Log(Msg: string; Color: TColor);
    function FindAllFiles(Path: string): Boolean;
  public

  end;

var
  fmDeleteEmptyFolders: TfmDeleteEmptyFolders;

implementation

{$R *.dfm}


uses
  uRegistry, FileCtrl;

{$REGION 'procedure TfmDeleteEmptyFolders.FormCreate(Sender: TObject);'}
procedure TfmDeleteEmptyFolders.FormCreate(Sender: TObject);
begin
  Processing := False;
  lblCaption.Caption := cAppTitle;
  Caption :=cAppTitle;

  LoadFormState(Self, cAppRegistryRoot);
  edtPath.Text := LoadFromRegistry(cAppRegistryRoot, 'LastFolder', ExtractFilePath(Application.ExeName));

end;
{$ENDREGION}

{$REGION 'procedure TfmDeleteEmptyFolders.FormClose(Sender: TObject; var Action: TCloseAction);'}
procedure TfmDeleteEmptyFolders.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveFormState(Self, cAppRegistryRoot);
  SaveToRegistry(cAppRegistryRoot, 'LastFolder', edtPath.Text);
end;
{$ENDREGION}

{$REGION 'procedure TfmDeleteEmptyFolders.Log(Msg: string; Color:TColor);'}
procedure TfmDeleteEmptyFolders.Log(Msg: string; Color: TColor);
begin
  logtext.SelAttributes.Color := Color;
  logtext.Lines.Add(Msg);
  logtext.SelStart := Length(logtext.Text);
  logtext.Perform(EM_SCROLLCARET, 0, 0);
end;
{$ENDREGION}

{$REGION 'procedure TfmDeleteEmptyFolders.edtPathButtonClick(Sender: TObject);'}
procedure TfmDeleteEmptyFolders.edtPathButtonClick(Sender: TObject);
var
  Directory: string;
begin
  if Processing then
      Exit;
  Directory := edtPath.Text;
  if SelectDirectory('Select Save Folder', '', Directory, [sdNewFolder, sdShowShares, sdNewUI, sdValidateDir]) then
      edtPath.Text := Directory;
end;
{$ENDREGION}

procedure TfmDeleteEmptyFolders.btnStartClick(Sender: TObject);
begin
  if not Processing then begin
    logtext.Clear;
    Processing := True;
    logtext.SetFocus;
    btnStart.Caption := 'Stop';
    if DirectoryExists(edtPath.Text) then
        FindAllFiles(IncludeTrailingBackslash(edtPath.Text))
    else
        Log('Selected folder not found', clRed);
    if Processing then
        Log('Scan Complete', clPurple);
    Processing := False;
    btnStart.Caption := 'Start';
  end
  else begin
    Processing := False;
    Log('Error:Cancelled by user', clRed);
    btnStart.Caption := 'Start';
  end;
end;

{$REGION 'function TfmDeleteEmptyFolders.FindAllFiles(Path:string):Boolean;'}
function TfmDeleteEmptyFolders.FindAllFiles(Path: string): Boolean;
var
  FS: TSearchRec;
  FolderName: string;
begin
  if FindFirst(Path + '*.*', faAnyFile, FS) = 0 then begin
    Result := True;
    repeat
      if (FS.Name = '.') or (FS.Name = '..') then
          Continue;
      if (FS.Attr and faDirectory) = faDirectory then begin
        FolderName := Path + FS.Name;
        Log(FolderName, clGreen);
        if FindAllFiles(IncludeTrailingBackslash(FolderName)) then begin
          try
            if RemoveDir(FolderName) then
                Log('  Removed ' + FolderName, clBlue)
            else
                Log('  Cannot Delete ' + FolderName, clRed);
          except
            on ex: Exception do begin
              Log('  Error:' + ex.Message, clRed);
            end;
          end;
        end
        else
            Result := False;
      end
      else
          Result := False;
      Application.ProcessMessages;
    until FindNext(FS) <> 0;
    FindClose(FS);
  end
  else
      Result := True;
end;
{$ENDREGION}

end.
