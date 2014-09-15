program hello;

uses
  System.StartUpCopy,
  FMX.Forms,
  uHello in 'uHello.pas' {TabbedForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTabbedForm, TabbedForm);
  Application.Run;
end.
