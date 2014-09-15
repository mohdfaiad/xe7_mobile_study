unit uHello;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.ExtCtrls, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  FMX.ListView.Types, FMX.ListView, FMX.ListBox, FMX.Layouts, System.Actions,
  FMX.ActnList;

type
  TTabbedForm = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    GestureManager1: TGestureManager;
    ToolBar1: TToolBar;
    Label1: TLabel;
    btnHello: TButton;
    lblHello: TLabel;
    PopupBox1: TPopupBox;
    CalloutPanel1: TCalloutPanel;
    ImageControl1: TImageControl;
    ProgressBar1: TProgressBar;
    TrackBar1: TTrackBar;
    BindingsList1: TBindingsList;
    LinkControlToPropertyValue: TLinkControlToProperty;
    TabControlSetting: TTabControl;
    tabSetting: TTabItem;
    tabWifi: TTabItem;
    lstSetting: TListBox;
    ListBoxItem1: TListBoxItem;
    Switch1: TSwitch;
    itemWifi: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxGroupFooter1: TListBoxGroupFooter;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ActionList1: TActionList;
    ChangeTabActionWifi: TChangeTabAction;
    ToolBar2: TToolBar;
    Label2: TLabel;
    Button1: TButton;
    ChangeTabActionSetting: TChangeTabAction;
    ListBox1: TListBox;
    ListBoxItem2: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    Switch2: TSwitch;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem7: TListBoxItem;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure btnHelloClick(Sender: TObject);
    procedure itemWifiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TabbedForm: TTabbedForm;

implementation

{$R *.fmx}
{$R *.iPhone4in.fmx IOS}
{$R *.LgXhdpiPh.fmx ANDROID}

//2014.9.13.
//点击按钮，显示hello
procedure TTabbedForm.btnHelloClick(Sender: TObject);
begin
  lblHello.Text:='Hello';
end;

//2014.9.14.
procedure TTabbedForm.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := TabItem1;

  //set setting tab default
  TabControlSetting.ActiveTab:=tabSetting;

  //set property TabPosition to None, don't show the tab
  tabcontrolSetting.TabPosition:=fmx.TabControl.TTabPosition.None;
end;

//2014.9.13.
//android可以用手势控制切换tab
procedure TTabbedForm.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
{$IFDEF ANDROID}
  case EventInfo.GestureID of
    sgiLeft:
    begin
      if TabControl1.ActiveTab <> TabControl1.Tabs[TabControl1.TabCount-1] then
        TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex+1];
      Handled := True;
    end;

    sgiRight:
    begin
      if TabControl1.ActiveTab <> TabControl1.Tabs[0] then
        TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex-1];
      Handled := True;
    end;
  end;
{$ENDIF}
end;

//2014.9.14.
procedure TTabbedForm.itemWifiClick(Sender: TObject);
begin
  ChangeTabActionWifi.ExecuteTarget(self);
end;

end.
