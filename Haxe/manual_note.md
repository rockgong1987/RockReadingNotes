# Haxe Manual  
## Introduction  
### 1. What is Haxe  
### 2. About this Document  
### 3. Hello World  
    class Main {
        static public function main():Void {
            trace("Hello World");
        }
    }
.hx extension;  
-main Main;  
class name Main upper case, function name name lower case;  
class name == file name;  
### 4. History  
2005, Nicolas Cannasse, begins;  
Hugh Sanderson(C++), Bruno Garcia(JavaScript), Simon Krajewski(Haxe 3);  
2012, Haxe Foundation;  
2013, Haxe 3 released;  
## Types  
7 type groups:
- Class instance  
- Enum instance  
- Structure  
- Function  
- Dynamic  
- Abstract  
- Monomorph  
### Basic Types  
Bool : true false  
Int : 1, 0, -1, 0xFF0000  
Float : 1.0, 0.0, -1.0, Float  
basic types are not classes;  
they are implemented as abstract types;  
use Int as Float : OK; use Float as Int : not allowed;  
haxe.Int32, haxe.Int64 can be used;  

    var x:Void; // not allowd  

### Nullability  
- **nullable**  
null is a valid value
- **Static target**  
null is not a valid value for basic types (Flash, C++, Java, C#)
- **Dynamic target**  
null is valid for basic types(JavaScript, PHP, Neko, Flash 6-8)
- **Default values**  
Int:0; Float:0.0(NaN on Flash); Bool:false;  
### 
    var a:Int = null; // error on static platforms
    var b:Null<Int> = null; //allowed

    var a : Int = 0;
    if (a == null) {...} // error on static platforms
    var b : Null<Int> = 0;
    if (b != null) {...} // allowed

- **Null\<T\>**  
static targets : Null\<Int\>, Null\<Float\>, Null\<Bool\>  
### 
    var n = Null<Int> = null;
    var a : Int = n;
    trace(a); //  0 on static platforms

- optional arguments and nullability  
### 
    function foo(x : Int = 0) {} // x is a native Int (not nullable)
    function bar(?y : Int) {} // y is Null<Int> (nullable)
    function opt(?z : Int) {} // z is alse Null<Int>
### Class Instance  
    class Point {
        var x:Int;
        var y:Int;

        public function new(x, y) {
            this.x = x;
            this.y = y;
        }

        public function toString() {
            return "Point(" + x + "," + y + ")";
        }
    }
- **Class\<T\>**  
common base type of all class types; a class, not a specific one  
#### constructor :  
    var p = new Point(-1, 65);
#### Inheritance :  
    class Point3 extends Point {
        var z : Int;

        public function new(x, y, z) {
            super(x, y);
            this.z = z;
        }
    }
**final** keyword prevent class from being extended  
#### Interfaces : 
    interface Printable {
        public var x:Float;
        public var y:Float;

        public function toString():String;
    }
    
    class Main implements Printable {
        public var x:Float;
        public var y:Float;

        public function toString():String {
            return "Point(" + x + "," + y + ")";
        }
        static public function main() {}
    }

## TypeSystem  
## Class Fields  
## Expressions  
## Language Features  
## Compiler Usage  
## Macros  
## Standard Library  
## Haxelib  
## Target Details  
## Debugging  