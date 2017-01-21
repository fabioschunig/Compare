unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons;

type
  TfMain = class(TForm)
    lbArquivo1: TLabel;
    cbArquivo1: TComboBox;
    lbArquivo2: TLabel;
    cbArquivo2: TComboBox;
    bOK: TBitBtn;
    sbArq1: TSpeedButton;
    sbArq2: TSpeedButton;
    dlgOpen: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bOKClick(Sender: TObject);
    procedure sbArq1Click(Sender: TObject);
    procedure sbArq2Click(Sender: TObject);
  private
    { Private declarations }
    FsComparador: string;
    FsDiretorio: string;
    FsListaArquivos1: string;
    FsListaArquivos2: string;

    procedure CarregarConfiguracoes;
    procedure PreencherComboBox(oCombo: TComboBox; sLista: string);
    procedure ConfigurarTela;
    function GerarLista(oCombo: TComboBox): string;
    procedure SalvarConfiguracoes;
    procedure AdicionarItem(oCombo: TComboBox; sArquivo: string);
    procedure AbrirArquivo(oCombo: TComboBox);
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

uses
  ShellApi, IniFiles;

{$R *.DFM}

procedure TfMain.FormCreate(Sender: TObject);
begin
  CarregarConfiguracoes;
  ConfigurarTela;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SalvarConfiguracoes;
end;

procedure TfMain.CarregarConfiguracoes;
var
  oINI: TIniFile;
begin
  oINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    FsComparador := oINI.ReadString('Comparador', 'Comparador', '');
    FsDiretorio := oINI.ReadString('Comparador', 'Diretorio', '');
    FsListaArquivos1 := oINI.ReadString('Arquivos', 'ListaArquivos1', '');
    FsListaArquivos2 := oINI.ReadString('Arquivos', 'ListaArquivos2', '');
  finally
    FreeAndNil(oINI);
  end;
end;

procedure TfMain.PreencherComboBox(oCombo: TComboBox; sLista: string);
var
  iPos: integer;
begin
  oCombo.Items.Clear;
  while sLista <> '' do
  begin
    iPos := Pos(';', sLista);
    if iPos = 0 then
    begin
      oCombo.Items.Add(trim(sLista));
      sLista := '';
    end
    else
    begin
      oCombo.Items.Add(trim(copy(sLista, 1, iPos - 1)));
      sLista := copy(sLista, iPos + 1, length(sLista));
    end;
  end;
  oCombo.ItemIndex := 0;
end;

procedure TfMain.ConfigurarTela;
begin
  PreencherComboBox(cbArquivo1, FsListaArquivos1);
  PreencherComboBox(cbArquivo2, FsListaArquivos2);
end;

function TfMain.GerarLista(oCombo: TComboBox): string;
var
  i: integer;
begin
  result := '';
  for i := 0 to oCombo.Items.Count - 1 do
    result := result + oCombo.Items[i] + ';';
end;

procedure TfMain.SalvarConfiguracoes;
var
  oINI: TIniFile;
begin
  oINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    oINI.WriteString('Comparador', 'Diretorio', FsDiretorio);
    oINI.WriteString('Arquivos', 'ListaArquivos1', GerarLista(cbArquivo1));
    oINI.WriteString('Arquivos', 'ListaArquivos2', GerarLista(cbArquivo2));
  finally
    FreeAndNil(oINI);
  end;
end;

procedure TfMain.AdicionarItem(oCombo: TComboBox; sArquivo: string);
var
  iIdx: integer;
begin
  iIdx := oCombo.Items.IndexOf(sArquivo);
  if iIdx >= 0 then
    oCombo.Items.Delete(iIdx);
  oCombo.Items.Insert(0, sArquivo);
  oCombo.ItemIndex := 0;
end;

procedure TfMain.bOKClick(Sender: TObject);
var
  sCmd: string;
begin
  AdicionarItem(cbArquivo1, cbArquivo1.Text);
  AdicionarItem(cbArquivo2, cbArquivo2.Text);

  sCmd := FsComparador + ' "' + cbArquivo1.Text + '" "' + cbArquivo2.Text + '"';
  WinExec(PChar(sCmd), SW_SHOWNORMAL);

  Close;
end;

procedure TfMain.AbrirArquivo(oCombo: TComboBox);
begin
  if dlgOpen.Execute then
  begin
    oCombo.Text := dlgOpen.FileName;
    FsDiretorio := ExtractFilePath(dlgOpen.FileName);
  end;
end;

procedure TfMain.sbArq1Click(Sender: TObject);
begin
  AbrirArquivo(cbArquivo1);
end;

procedure TfMain.sbArq2Click(Sender: TObject);
begin
  AbrirArquivo(cbArquivo2);
end;

end.

