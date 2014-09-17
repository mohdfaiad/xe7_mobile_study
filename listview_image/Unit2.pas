unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions, FMX.Objects,
  FMX.Layouts, FMX.ListBox, FMX.TabControl;

type
  TForm2 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    GridLayout1: TGridLayout;
    Image1: TImage;
    Image2: TImage;
    ActionList1: TActionList;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    procedure ListBoxItem1Click(Sender: TObject);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}
{$R *.iPhone4in.fmx IOS}

procedure TForm2.ListBoxItem1Click(Sender: TObject);
begin
  TakePhotoFromLibraryAction1.ExecuteTarget(Sender);
end;

procedure TForm2.TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
begin
  Image1.MultiResBitmap.Items[0].Bitmap.Assign(image);
end;

end.
