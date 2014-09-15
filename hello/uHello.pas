unit uHello;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.ExtCtrls, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
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
    ListBoxWifi: TListBox;
    ListBoxItem2: TListBoxItem;
    SwitchWifi: TSwitch;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure btnHelloClick(Sender: TObject);
    procedure itemWifiClick(Sender: TObject);
    procedure SwitchWifiSwitch(Sender: TObject);
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

// 2014.9.13.
// �����ť����ʾhello
procedure TTabbedForm.btnHelloClick(Sender: TObject);
begin
  lblHello.Text := 'Hello';
end;

// 2014.9.14.
procedure TTabbedForm.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := TabItem1;

  // set setting tab default
  TabControlSetting.ActiveTab := tabSetting;

  // set property TabPosition to None, don't show the tab
  TabControlSetting.TabPosition := FMX.TabControl.TTabPosition.None;
end;

// 2014.9.13.
// android���������ƿ����л�tab
procedure TTabbedForm.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
{$IFDEF ANDROID}
  case EventInfo.GestureID of
    sgiLeft:
      begin
        if TabControl1.ActiveTab <> TabControl1.Tabs[TabControl1.TabCount - 1]
        then
          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex + 1];
        Handled := True;
      end;

    sgiRight:
      begin
        if TabControl1.ActiveTab <> TabControl1.Tabs[0] then
          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex - 1];
        Handled := True;
      end;
  end;
{$ENDIF}
end;

// 2014.9.14.
procedure TTabbedForm.itemWifiClick(Sender: TObject);
begin
  ChangeTabActionWifi.ExecuteTarget(self);
end;

// 2014.9.15.
procedure TTabbedForm.SwitchWifiSwitch(Sender: TObject);
var
  ListBoxItem: TListBoxItem;
  i: integer;
begin
  // true
  if SwitchWifi.IsChecked then
  begin
    ListBoxItem := TListBoxItem.Create(ListBoxWifi);
    ListBoxItem.Text := '����������';
    ListBoxItem.ItemData.Accessory := TListBoxItemData.TAccessory(2);
    ListBoxItem.Height := 44;
    ListBoxItem.StyleLookup := 'listboxitemrightdetail';

    ListBoxWifi.AddObject(ListBoxItem);
  end
  else
  // false
  begin
    for i := 0 to ListBoxWifi.ComponentCount - 1 do
    begin
      if ListBoxWifi.Components[i] is TListBoxItem then
        if (ListBoxWifi.Components[i] as TListBoxItem).Text = '����������' then
          ListBoxWifi.RemoveObject((ListBoxWifi.Components[i] as TListBoxItem));
    end;

  end;
end;

end.
