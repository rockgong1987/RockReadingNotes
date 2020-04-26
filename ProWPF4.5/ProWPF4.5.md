# Pro WPF 4.5 in C#
## Chapter 1 - Introducing WPF
Windows Presentation Foundation
### The Evolution of Windows Graphics
Pre WPF
- User32 : windows, buttons and so on
- GDI/GDI+ : drawing text, shapes, images
#### DirectX : new graphics engine
- DirectX is WPF underlying graphics engine
#### Hardware acceleration and WPF
Hardware and Software(fallback) renderring
### WPF : A Higher-Level API
- A web-like layut model
- A rich drawing model
- A rich text model
- Animation as a first-class programming concept
- Support for audio and video media
- Styles and templates
- Commands
- Declarative user interface
- Page-based applications
### Resolution Independence
120 dpi or 144 dpi or 96, same size button
#### WPF Units
using _device-independent units_. A single device-independent unit is defined as 1/96 of an inch
#### System DPI
#### Bitmap and Vector Graphics
- using bitmap for toolbar is not ideal(maybe blurry), vector is better
### The Architecture of WPF
![](img/101.png)
- PresentationFramework.dll : top-level WPF types, windows, panels, controls
- PresentationCore.dll : This holds base types, UIElement and Visual and so on(Shapes and Controls derive)
- WindowsBase.dll : more basic ingredients and protential reused outside of WPF, DispatcherObject and DependencyObject
- milcore.dll : Media Integration Layer
- WindowsCodecs.dll : low-level API provide imaging support(for example, processing, displaying, and scaling bitmaps and JPEGs)
- Direct3D : graphics API
- User32
#### The Class Hierarchy
![](img/102.png)
- **System.Threading.DispatcherObject** : WPF use STA(single thread affinity)
- **System.Windows.DependencyObject** : more powerful property model
- **System.Windows.Media.Visual**
- **System.Windows.UIElement** : layout, input, focus, events(LIFE)
- **System.Windows.FrameworkElement**
- **System.Windows.Shapes.Shape** : rectangle, polygon, ellipse, line, path
- **System.Windows.Controls.Control** : TextBox, Button, ListBox
- **System.Windows.Controls.ContentControl**
- **System.Windows.Controls.ItemsControl** : ListBox, TreeView
- **System.Windows.Control.Panel**
### WPF 4.5
#### The WPF Toolkit
#### Visual Studio 2012
## Chaper 2 - XAML
XAML documents define the arrangement of panels, buttons, and controls that make up the windows in a WPF application.
### Understanding XAML
#### Graphical User Interfaces Before WPF
- XAML opens up worlds of possibilites for collaboration, because other design tools understand the XAML format(for example, Microsoft Expression Design)
#### The Variants of XAML
- XAML is and all-purpose XML-based syntax for representing a tree of .NET objects
- Subsets of XAML
    - WPF XAML
    - XPS XAML part of WPF XAML, defines XML representation for formatted electronic documents(XML Paper Specification)
    - Silverlight XAML, subset of WPF XAML
    - WF XAML, Workflow foundation
#### XAML Compilation
- XAML Compiles to BAML(Binary representation of XAML)
### XAML Basics
- every element in a XAML document maps to an instance of a .NET class.
- you can nest one element inside another.
- you can set the properties of each class through attributes