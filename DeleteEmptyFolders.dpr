program DeleteEmptyFolders;

uses
  Forms,
  uDeleteEmptyFolders in 'uDeleteEmptyFolders.pas' {fmDeleteEmptyFolders},
  uRegistry in 'uRegistry.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Delete Empty Folders';
  Application.CreateForm(TfmDeleteEmptyFolders, fmDeleteEmptyFolders);
  Application.Run;
end.
