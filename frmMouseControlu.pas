unit frmMouseControlu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CalcEdit, Vcl.ExtCtrls,
  AdvEdit, Vcl.Samples.Spin, Vcl.Buttons;

type
  TForm2 = class(TForm)
    Timer1: TTimer;
    AdvEdit1: TAdvEdit;
    AdvEdit2: TAdvEdit;
    Label1: TLabel;
    Label2: TLabel;
    chkbxActive: TCheckBox;
    spedMonitor: TSpinEdit;
    Label3: TLabel;
    chkbxClick: TCheckBox;
    Memo1: TMemo;
    spbtnLeft: TSpeedButton;
    procedure chkbxActiveClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spbtnLeftClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

// *****************************************************
// Add a comment to show willing
// *****************************************************

implementation

{$R *.dfm}

procedure TForm2.chkbxActiveClick(Sender: TObject);
begin
  timer1.Enabled:=chkbxActive.Checked;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  spedMonitor.MaxValue:=Screen.MonitorCount;
end;

procedure TForm2.spbtnLeftClick(Sender: TObject);
begin
 AdvEdit1.Text:=IntToStr(strTointDef(AdvEdit1.Text,0)-50);
 chkbxActiveClick(nil);

end;

procedure TForm2.Timer1Timer(Sender: TObject);
var theLeft : integer;
var theHeight : Integer;
begin
  Timer1.Enabled:=false;
  if spedMonitor.Value <=0 then
  begin
    theLeft:=0;
    theHeight:=0;
  end
  else
  begin
    theLeft:=screen.Monitors[spedMonitor.Value-1].Left;
    theHeight:=Screen.Monitors[spedMonitor.Value-1].Height+Screen.Monitors[spedMonitor.Value-1].top;
    Memo1.Lines.Add(format('Monitor: %d Left: %d, Width: %d, top: %d, height: %d',[spedMonitor.Value-1,Screen.Monitors[spedMonitor.Value-1].Left,Screen.Monitors[spedMonitor.Value-1].Width,Screen.Monitors[spedMonitor.Value-1].Top,Screen.Monitors[spedMonitor.Value-1].Height]));
  end;
    //  https://www.delphitips.net/2007/08/18/simulate-mouse-moves-and-clicks/
  theLeft:=theLeft+StrToIntDef(AdvEdit1.text,20);
  theHeight:=theHeight-StrToIntDef(AdvEdit2.text, 20);
  Memo1.Lines.Add(format('Mouse: %d Left: top: %d',[theLeft,theHeight]));

  SetCursorPos(theLeft, theHeight); //set cursor to Start menu coordinates
  if chkbxClick.Checked then
  begin
    mouse_event(MOUSEEVENTF_LEFTDOWN,0, 0, 0, 0); //press left button
    mouse_event(MOUSEEVENTF_LEFTUP,0, 0, 0, 0); //release left button
    Memo1.Lines.Add('Click');
  end;
end;

end.
