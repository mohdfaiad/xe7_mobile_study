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
    ListBoxItemWifiSetting: TListBoxItem;
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
    ListBoxItemWifi: TListBoxItem;
    SwitchWifi: TSwitch;
    TabItem5: TTabItem;
    ToolBar3: TToolBar;
    Label3: TLabel;
    Button2: TButton;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem2: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    TrackBar2: TTrackBar;
    Switch2: TSwitch;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure btnHelloClick(Sender: TObject);
    procedure ListBoxItemWifiSettingClick(Sender: TObject);
    procedure SwitchWifiSwitch(Sender: TObject);
    procedure ChangeTabActionSettingUpdate(Sender: TObject);
  private
    { Private declarations }
    WifiName: string;
    WifiCount: integer;
    procedure WifiListItemClick(Sender: TObject);
  public
    { Public declarations }
  end;

var
  TabbedForm: TTabbedForm;

implementation

{$R *.fmx}
{$R *.iPhone4in.fmx IOS}
{$R *.LgXhdpiPh.fmx ANDROID}

uses System.Math, CodeSiteLogging;

// 2014.9.13.
// 点击按钮，显示hello
procedure TTabbedForm.btnHelloClick(Sender: TObject);
begin
  lblHello.Text := 'Hello';
end;

// 2014.9.14.
procedure TTabbedForm.ChangeTabActionSettingUpdate(Sender: TObject);
begin
  ListBoxItemWifiSetting.ItemData.Detail := WifiName;
end;

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
// android可以用手势控制切换tab
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
procedure TTabbedForm.ListBoxItemWifiSettingClick(Sender: TObject);
begin
  ChangeTabActionWifi.ExecuteTarget(self);

  codesite.send('listboxwifi component count', ListBoxWifi.ComponentCount);
end;

// 2013.9.14.
// wifi listitem点击事件处理
procedure TTabbedForm.WifiListItemClick(Sender: TObject);
var
  ListBoxItem: TListBoxItem;
  lbMark: Boolean;
begin
  WifiName := (Sender as TListBoxItem).Text;

  // 是否已经存在选中的wifi item , 存在则直接修改wifi item text
  if (ListBoxWifi.FindComponent('listboxitem_wifi_select')) <> nil then
    (ListBoxWifi.FindComponent('listboxitem_wifi_select') as TListBoxItem).Text
      := WifiName
    // 没有使用过，生成wifi item for select
  else
  begin
    ListBoxItem := TListBoxItem.Create(ListBoxWifi);
    ListBoxItem.Text := WifiName;
    ListBoxItem.ItemData.Accessory := TListBoxItemData.TAccessory(2);
    ListBoxItem.Height := 44;
    ListBoxItem.StyleLookup := 'listboxitemrightdetail';
    ListBoxItem.Name := 'listboxitem_wifi_select';

    ListBoxWifi.InsertObject(1, ListBoxItem);
  end;
end;

// 2014.9.15.
// wifi switch
procedure TTabbedForm.SwitchWifiSwitch(Sender: TObject);
var
  ListBoxGroupHeader: TListBoxGroupHeader;
  ListBoxItem: TListBoxItem;
  i: integer;
begin
  // true
  if SwitchWifi.IsChecked then
  begin

    ListBoxGroupHeader := TListBoxGroupHeader.Create(ListBoxWifi);
    ListBoxGroupHeader.Text := '选取网络';
    ListBoxGroupHeader.Name := 'listboxgroupheader_wifi';
    ListBoxWifi.AddObject(ListBoxGroupHeader);

    WifiCount := System.Math.RandomRange(1, 10);
    // add random wifi info listitem
    for i := 1 to WifiCount do
    begin
      ListBoxItem := TListBoxItem.Create(ListBoxWifi);
      ListBoxItem.Text := 'wifi_' +
        IntToStr(System.Math.RandomRange(100, 1000));
      ListBoxItem.ItemData.Accessory := TListBoxItemData.TAccessory(2);
      ListBoxItem.Height := 44;
      ListBoxItem.StyleLookup := 'listboxitemrightdetail';
      ListBoxItem.Name := 'listboxitem_wifi_' + IntToStr(i);

      // 挂钩listitem点击事件
      ListBoxItem.OnClick := WifiListItemClick;

      ListBoxWifi.AddObject(ListBoxItem);
    end;
  end
  else
  // false
  // 删除所有wifi相关的listitem
  begin
    (ListBoxWifi.FindComponent('listboxgroupheader_wifi')
      as TListBoxGroupHeader).Free;

    for i := 1 to WifiCount do
    begin
      (ListBoxWifi.FindComponent('listboxitem_wifi_' + IntToStr(i))
        as TListBoxItem).Free;
    end;

    (ListBoxWifi.FindComponent('listboxitem_wifi_select') as TListBoxItem).Free;

    codesite.send('listboxwifi component count', ListBoxWifi.ComponentCount);

  end;
end;

end.
