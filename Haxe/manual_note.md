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
#### Enum Instance : 
    enum Color {
        Red;
        Green;
        Blue;
        Rgb(r:Int, g:Int, b:Int);
    }
    var a = Red;
    var b = Green;
    var c = Rgb(255, 255, 0);
    var ec:EnumValue = Red; // valid
    var en:Enum<Color> = Color; // valid
    
    var color = getColor();
    switch(color) {
        case Red:
            trace("Color was red");
        case Green:
            trace("Color was green");
        case Blue:
            trace("Color was blue");
        case Rgb(r, g, b):
            trace("Color had a red value of " + r);
    }
#### 
- **Enum\<T\>**  
common bse type of all enum types.
#### Anonymous Structure  
    class Main {
        static public function main() {
            var myStructure = {x:12, name:"floo"};
            var user = {
                name : "Nicolas",
                age : 32,
                pos : [
                    {x : 0, y : 0},
                    {x : 1, y : -1}
                ],
            };
            user.name;
            user.age = 33;
        }
    }

    typedef Point = {x : Int, Y : Int}
    class Path {
        var start : Point;
        var target : Point;
        var current : Point;
    }

    typedef Point3 = { > Point, z : Int} // Extension(Inherit)
#### JSON for structure values
    var point = {"x" : 1, "y" : -5}; // key can be String  
#### Class Notation for Structure Types
    typedef Point = { // define a Struct
        var x : Int;
        var y : Int;
    }
#### Optional Fields
    typedef User = {
        age : Int,
        name : String,
        ?phoneNumber : String
    }
    typedef User = {
        var age : Int,
        var name : String;
        @:optional var phoneNumber : String; // declare with annotation
    }
    typedef User = {
        var age : Int,
        var name : String;
        var ?optional var phoneNumber : String;
    }
#### Impact on Performance  
- dynamic targets  
no impact
- static targets  
has impact
#### Extensions
    typedef IterableWithLength<T> = {
        > Iterable<T>,
        var length(default, null):Int;
    }
    class Main {
        static public function main() {
            var array = [1, 2, 3];
            var t:IterableWithLength<Int> = array;
        }
    }

    // since Haxe 3.1.0 : multiple structures extension
    typedef WithLength = {
        var length(default, null) :Int;
    }

    typedef IterableWithLengthAndPush<T> = {
        > Iterable<T>,
        > WithLength,
        function push(a:T):Int;
    }

    // since Haxe 4.0.0 : &
    typedef Point2D = {
        var x : Int;
        var y : Int;
    }
    typedef Point3D = Point2D & {z : Int};
    class Main {
        static public function main() {
            var point:Point3D = {x : 5, y : 3, z : 1};
        }
    }
### Function Type  
"$type" : output the type its expression has during **compilation**  
### 
    class Main {
        static public function main() {
            // (i : Int, s : String) -> Bool
            $type(test);
            $type(test(1, "fool")); // Bool
            // (?i : Int, ?s : String) -> String
            $type(test_opt);
        }

        static function test(i:Int, s:String):Bool {
            return true;
        }
        static function test_opt(?i:Int, ?s:String) {
            return "i: " + i + ", s: " + s;
        }
    }
### Dynamic  
can be assigned to anything and anything can be assigned to it.  
Drawbacks :  
- compile without type checking
- some optimization disabled
- compile error -> runtime error
- Dead Code Elimiation disabled
### 
    class Main {
        static function main() {
            var jsonData = '[1, 2, 3]';
            var json = haxe.Json.parse(jsonData);
            $type(json); // Unknown<0>
            for (i in 0...json.length) {
                // Array access is not allowed on
                // {+ length : Int}
                trace(json[0]);
            }
        }
    }
#### Dynamic with Type Parameter  
    var att : Dynamic<String> = xml.attributes;
    // valid, value is a String
    att.name = "Nicolas";
    // dito (this documentation is quite old)
    att.age = "26";
    // error, value is not a String
    att.income = 0;
#### DynamicAccess
    class Main {
        static public function main() {
            var user : haxe.DynamicAccess<Dynamic> = {};

            // Sets values for specified keys.
            user.set("name", "Mark");
            user.set("age", 25);

            // Returns values by specified keys.
            trace(user.get("name")); // "Mark"
            trace(user.get("age")); // 25

            // Tells if the structure contains a specified key
            trace(user.exists("name")); // true
        }
    }
#### Any
    abstract Any(Dynamic) from Dyanmic to Dynamic {}
### 
    class Main {
        static function setAnyValue(value:Any) {
            trace(value);
        }
        static function getAnyValue():Any {
            return 42;
        }
        static function main() {
            // value of any type works;
            setAnyValue("someValue");
            setAnyValue(42);

            var value = getAnyValue();
            $type(value); // Any, not Unknown<0>

            // won't compile : no dynamic field access
            // value.charCodeAt(0);

            if (Std.is(value, String)) {
                // explicit promotion, type-safe
                trace((value : String).charCodeAt(0));
            }
        }
    }
### Abstract  
An abstract type is a type which is actually a different type at run-time. It is a **compile-time feature** which defines types "over" concrete types in order to modify or augment their behavior:  
### 
    abstract AbstractInt(Int) {
        inline public function new(i:Int) {
            this = i;
        }
    }
### 
- "abstract" denotes abstract type
- AbstractInt is the name of the abstract type
- Int is **Underlying type**
- fields enclosed in {}
- new function access one argument i of type Int
- **Underlying Type** is the type which is used to represent said abstract at runtime, It is usually a concrete(non-abstract) type but could be another abstract type as well.
### 
    class Main {
        static public function main() {
            var a = new AbstractInt(12);
            trace(a); // 12
        }
    }

    // -> haxe -- main MyAbstract --js myabstract.js
    var a = 12;
    console.log(a);
#### Implicit Casts
- Direct : adding "to" and "from" rules
- Class field : using "@:to" and "@:from" metadata
### 
Direct code : 
### 
    abstract MyAbstract(Int) from Int to Int {
        inline function new(i:Int) {
            this = i;
        }
    }
    class Main{
        static public function main() {
            var a : MyAbstract = 12;
            var b : Int = a;
        }
    }
### 
Class field casts have the same semantics, but are defined completely differently:
### 
    abstract MyAbstract(Int) {
        inline function new(i:Int) {
            this = i;
        }
        @:from
        static public function fromString(s:String) {
            return new MyAbstract(Std.parseInt(s));
        }
        @:to
        public function toArray() {
            return [this];
        }
    }

    class Main {
        static public function main() {
            var a:MyAbstract = "3";
            var b:Array<Int> = a;
            trace(b); // [3]
        }
    }
### 
The **selection algorithm** when assigning a type A to type B where at least one is an abstract is simple:  
1. if A is not an abstract, go to 3.
2. if A defines a to-conversion that admits B, go to 6.
3. if B is not an abstract, go to 5.
4. if B defines a from-conversion that admits A, go to 6.
5. Stop, unification fails.
6. Stop, unification succeeds.
### 
    abstract A(Int) {
        public function new()
            this = 0;
        
        @:to public function toB() return new B();
    }

    abstract B(Int) {
        public function new()
            this = 0;
        
        @:to public function toC() return new C();
    }

    abstract C(Int) {
        public function new()
            this = 0;
    }

    class Main {
        static public function main() {
            var a = new A();
            var b:B = a; // valid, used A.toB
            var c:C = b; // valid, used B.toC
            var c:C = a; // error, A should be C
        }
    }
#### Operator Overloading
    abstract MyAbstract(String) {
        public inline function new(s:String) {
            this = s;
        }

        @:op(A * B)
        public function repeat(rhs:Int):MyAbstract {
            var s:StringBuf = new StringBuf();
            for (i in 0...rhs)
                s.add(this)
            return new MyAbstract(s.toString());
        }
    }

    class Main {
        static public function main() {
            var a = new MyAbstract("foo");
            trace(a * 3); // foofoofoo
        }
    }
    // [] and a.b can be override since Haxe 4.0.0
#### Array Access
- if an @:arrayAccess method accepts one argument, it is a getter.
- if an @:arrayAccess method accepts two argument, it is a setter.
### 
    class Main {
        public static function main() {
            var map = new Map();
            map["foo"] = 1;
            tract(map["foo"]);
        }
    }
### 
    // since Haxe 3.2, fields are new consistently checked from top to bottom
    abstract AString(String) {
        public function new(s)
            this = s;
        
        @:arrayAccess function getInt1(k:Int) {
            return this.charAt(k);
        }
        @:arrayAccess function getInt2(k:Int) {
            return this.charAt(k).toUpperCase();
        }
    }
    class Main {
        static function main() {
            var a = new AString("foo");
            trace(a[0]);
        }
    }
#### Enum abstracts
    @:enum
    abstract HttpStatus(Int) {
        var NotFound = 404;
        var MethodNotAllowed = 405;
    }

    class Main {
        static public function main() {
            var status = HttpStatus.NotFound;
            var msg = printStatus(status);
        }

        static function printStatus(status:HttpStatus) {
            return switch(status) {
                case NotFound:
                    "Not found";
                case MethodNotAllowed:
                    "Method not allowed";
            }
        }
    }
    // since Haxe 4.0.0, @:enum abstract -> enum abstract
#### Forwarding abstract fields
    // to "keep" parts of its functionality.
    @:forward(push, pop)
    abstract MyArray<S>(Array<S>) {
        public inline function new() {
            this = [];
        }
    }
    class Main {
        static public function main() {
            var myArray = new MyArray();
            myArray.push(12);
            myArray.pop();
            // MyArray<Int> has no field length
            // myArray.length;
        }
    }
#### Core-type abstracts  
using @:coreType;  
- have no underlying type;
- considered nullable unless annotated with @:notNull;
- allowed to declare array access functions without expressions;
- Operator overloading fields that have no expression are not forced to adhere to the Haxe type semantics.
### Monomorph  
morph into a different type later. type inference function  

## TypeSystem  
### Typedef
    typedef IA = Array<Int>;
    typedef User = {
        var age : Int;
        var name : String;
    }
    typedef Iterable<T> = {
        function iterator() : Iterator<T>;
    }
### Type Parameters
    class Main {
        static public function main() {
            equals(1, 1);
            // runtime message : bar should be foo
            equals("foo", "bar");
            // compiler error : String should be Int
            equals(1, "foo");
        }
        static function equals<T>(expected:T, actual:T) {
            if (actual != expected) {
                trace('$actual should be $expected');
            }
        }
    }
#### Constraints
    typedef Measureable = {
        public var length(default, null) : Int;
    }
    class Main {
        static public function main() {
            trace(test([]));
            trace(test(["bar", "foo"]));
            // String should be Iterable<String>
            // test("foo");
        }
        #if (haxe_ver >= 4)
        static function test<T:Iterable<String> & Measurable>(a:T) {
        #else
        static function test<T:(Iterable<String, Meashureable>)> {
        #end
            if (a.length == 0)
                return "empty";
            return a.iterator().next();
        }
    }
### Generic
#### Construction of generic type parameter
    import haxe.Contraints;
    class Main {
        static public function main() {
            var s:String = make();
            var t:haxe.Template = make();
        }
        @:generic
        static function make<T:Constructible<String->Void>>():T {
            return new T("foo");
        }
    }
#### Variance
    class Base {
        public function new() {}
    }
    class Child extends Base {}
    class Main {
        public static function main() {
            var children = [new Child()];
            // Array<Child> should be Array<Base>
            // Type paremeters are invariant
            // Child should be Base
            var bases:Array<Base> = children;
            // Covariance and Contravariance is just normal
        }
    }
#### Unification
- Unification
    - Unification between two types A and B is a directional process which answers one question : whether A **can be assigned** to B. It may mutate either type if it either is or has a monomorph
- Structural Subtyping
#### Type Inference
    class Main {
        public static function main() {
            var x = null;
            $type(x); // Unknown<0>
            x = "foo";
            $type(x); // String

            var y = [];
            $type(y); // Array<Unknown<0>>
            y.push("foo");
            $type(y); // Array<String>
        }
    }
#### Top-down Inference
- Expected Type
### 
    import haxe.Constraints;
    class Main {
        static public function main() {
            var s:String = make();
            var t:haxe.Template = make();
        }

        @:generic
        static function make<T:Constructible<String->Void>():T {
            return new T("foo");
        }
    }
### Modules and Paths
- Module
  - All Haxe is organized in modules, which are addressed using paths. In essence, each .hx file represents a module which may contain several types. A type may be private, in which case only its containing module can access it.
- for **haxe.ds.StringMap.StringMap\<Int\>**
  - the package haxe.ds
  - the module name StringMap
  - the type name StringMap
  - the type parameter Int
  - If the module and type name are equal(haxe.ds.StringMap\<Int\> for short)
- Type path
  - general form : pack1.pack2.packN.ModuleName.TypeName
#### Module Sub-Types
- module sub-type is type declared in a module with a different name than that module
### 
    // a/A.hx
    package a;
    class A {public function() {} }
    // sub-type
    class B {public function() {} }
### 
    // Main.hx
    import a.A
    class Main {
        static function main() {
            var subtype1 = new a.A.B();
            // these is also valid, but require imort a.A or import a.A.B :
            var subtype2 = new B();
            var subtype3 = new a.B();
        }
    }
### 
- private type can only be directly accessed from within the module it is defined in.
#### Import
- use import to shorten code
### 
    import haxe.ds.StringMap;
    class Main {
        static public function main() {
            // instead of : new haxe.ds.StringMap();
            new StringMap();
        }
    }
    import Math.random; // import static fields of a class and use them unqualified
    class Main {
        static public function main() {
            random();
        }
    }
    import haxe.macro.*; // wildcard import
    class Main {
        static function main() {
            var expr:Expr = null;
            // var expr:ExprDef = null; // Class not found : ExprDef
        }
    }
    import String.fromCharCode in f; // import with alias; 'as' can be used instead of 'in' since Haxe 3.2.0
    class Main {
        static function main() {
            var c1 = f(65);
            var c2 = f(66);
            trace(c1 + c2); // AB
        }
    }
#### import defaults/import.hx
- since Haxe 3.3.0, import.hx can be used
  - import.hx is a specified name
  - must be placed in the same directory as your code
  - can only contain import and using statements
#### Resolution Order
### untyped
- should be avoid, until absolutely necessary
## Class Fields  
### Variable
### Property
    class Main {
        public var x(default, null):Int; // first identifier (default) is for read, second identifier is for write
    }
###
    class Main {
        // read from outside, write only within Main
        public var ro(default, null):Int;

        // write from outside, read only within Main
        public var wo(null, default):Int;

        // access through getter get_x and setter set_x
        public var x(get, set):Int;

        // read access through getter, no write access
        public var y(get, never):Int;

        // requried by field x
        function get_x() return 1;

        // requried by field x
        function set_x(x) return x;

        // requried by field y
        function get_y() return 1;

        function new() {
            var v = x;
            x = 2;
            x += 1;
        }
    }
### Method
#### override method
    class Base {
        public function new() {}

        public function myMethod() {
            return "Base";
        }
    }
    class Child extends Base {
        public override function myMethod() {
            return "Child";
        }
    }
    class Main {
        static public function main() {
            var child:Base = new Child();
            trace(child.myMethod()); // Child
        }
    }
### Access Modifier
- dynamic : support re-bind
### 
    class Main {
        static dynamic function test() {
            return "original";
        }

        static public function main() {
            trace(test());
            test = function() {
                return "new";
            }
            trace(test());
        }
    }
### 
- extern : The extern keyword causes the compiler to not generate the field in the output. This can be used in combination with the inline keyword to force a field to be inlined (or cause an error if this is not possible). Forcing inline may be desirable in abstracts or extern classes.
## Expressions
### Blocks
- support variable shadowing
### Literals
- Map : {"a" => 2}
### var and final
- final : readonly
### Local function
- since 4.0.0 : arrow function (a:Int, b:Int) -> a + b
### new  
### for  
- for (v in list)
- for (i in 0...10)
- for (k => v in e1) // since Haxe 4.0.0
### while
### do-while
### switch
    switch subject {
        case pattern1: exp;
        case pattern2: exp;
        default: exp;
    }
### throw
- can be caught by catch block
- haxe.Callstack.exceptionStack() is useful
### try/catch
    try try-expr
    catch (varName1:Type1) catch-expr-1
    catch (varName2:Type2) catch-expr-2
### return
### break
### continue
### cast
#### unsafe cast
- cast to monomorph
### 
    class Main {
        public static function main() {
            var i = 1;
            $type(i); // Int
            var s = cast i;
            $type(s); // unknown<0>
            Std.parseInt(s);
            $type(s); // String
        }
    }
#### safe cast
    class Base {
        public function new() {}
    }
    class Child1 extends Base {}
    class Child2 extends Base {}
    class Main {
        public static function main() {
            var child1:Base = new Child1();
            var child2:Base = new Child2();
            cast(child1, Base); // OK
            cast(child1, Child2); // Exception : Class cast error
        }
    }
### inline
## Language Features  
### Conditional Complilation
- Compiler Flag
  - -D key=value or -D key
### Externs
- Externs can be used to describe target-specific interaction in a type-safe manner.
- like normal classes, except that
  - the class keyword is preceded by the extern keyword
  - methods have no expressions
  - all argument and return types are explicit, and
  - the default visibility is public
#### Native Metadata
- With @:native("final") var final_:Int;
#### Implementing Dynamic
### Static Externsion
- allows pseudo-extensing existing types without modifying their source
## Compiler Usage 
- Common arguments
  - Input:
    - -p \<path\> or --class-path\<path\> add a class path where .hx source files or packages(sub-directories) can be found
    - -L \<library-name\> add a Haxelib library.default recent version, to require a specific version, use -L library_name:version
    - -m \<dot_path\> main class
    - -D key or -D key=value : conditional compilation flag
  - Output:
    - --js file_name.js, generate JavaScript source code in specified file
    - --swf
    - --neko
    - --php
    - --cpp
    - --cs
    - --java
    - --python
    - --lua
    - --hl
    - --cppia
    - --x \<file\>
    - --no-output : compile but do not generate any file
    - --interp : interpret the program using internal macro system
  - Other global arguments
    - --run \<module\> [args...] compile and execute a Haxe module with command line arguments
    - --xml \<file\> generate XML types descript. useful for API documentation generation tools like Dox.
    - -v verbose
    - --dce \<std|full|no\> : dead code elimination mode (default std)
## Complier Features 
## Macros  
- The role of macros during compliation
- ![](img/3.png)
- a basic macro is a syntax-transformation, it receives zero or more expressions and also returns an exporession
- different kinds of macros, run at specific complication stages
  - Initialization Macros
    - provided by command line using the --macro compiler parameter
    - executed after the compiler arguments were processed and the **typer context** has been created, before any typing was done
  - Build Macros
    - defined for classes, enums and abstracts through the @:build or @autoBuild metadata
    - executed after the type has been set up (including its relation to other types, such as inheritance for classes), before its fields are typed
  - Expression Macros
    - executed as soon as they are typed
#### Macro Context
- environment in which the macro is executed, depending on the macro type
- obtained through the haxe.macro.Context
- different contextual information can be accessed, depending on the macro type
- Initialization macros
  - Context.getLocal*() return null
- Build macros
  - has return value from context.getBuildFields()
  - has local type, but no local method, so Context.getLocalMethod() returns null
#### Arguments
    import haxe.macro.Expr;
    class Main {
        static public function main() {
            var x = 0;
            var b = add(x++);
            trace(x); // 2
        }
        macro static function add(e:Expr) {
            return macro $e + $e;
        }
    }
##### ExprOf
- type limited Expr, Expr\<T\>
##### Constant Expressions
    class Main {
        static public function main() {
            const("foo", 1, 1.5, true);
        }

        macro static function const(s:String, i:Int, f:Float, b:Bool) {
            trace(s);
            trace(i);
            trace(f);
            trace(b);
            return macro null;
        }
    }
##### Rest Argument
    // final argument of a macro is of type Array<Expr>
    import haxe.macro.Expr;
    class Main {
        static public function main() {
            myMacro("foo", a, b, c);
        }
        macro static functino myMacro(e1:Expr, extra:Array<Expr>) {
            for (e in extra) {
                trace(e);
            }
            return macro null;
        }
    }
#### Reification
- syntax : _macro expr_, where _expr_ is any valid Haxe expression
##### Expression Reification
- ${} and $e{} : Expr -> Expr
- $a{} : Array\<Expr\> -> Array\<Expr\>
- $b{} : Array\<Expr\> -> Expr
- $i{} : String -> Expr
- $p{} : Array\<String\> -> Expr
- $v{} : Dynamic -> Expr
##### Type Reification
- syntax : _macro : Type_, where _Type_ can be any valid type path expression
    - TPath : macro : pack.Type
    - TFunction : macro : Arg1 -> Arg2 -> Return
    - TAnonymous : macro : { field: Type}
    - TParent : macro : (Type)
    - TExtend : macro : {> Type, field : Type }
    - TOptional : macro : ?Type
##### Class Reification
- to obtain an instance of haxe.macro.Expr.TypeDefinition
- syntax : _macro class_
### 
    class Main {
        macro static function generateClass(funcName:String) {
            var c = macro class MyClass {
                public function new() {}
                public function $funcName() {
                    trace($v{funcName} + " was called");
                }
            }
            haxe.macro.Context.defineType(c);
            return macro new MyClass();
        }

        public static function main() {
            var c = generateClass("myFunc");
            c.myFunc();
        }
    }
#### Tools
- using haxe.macro.Tools
## Standard Library  
## Haxelib  
## Target Details  
## Debugging  