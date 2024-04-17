# rust概念

## 范型

范型是一种在编程语言中使用类型参数来编写代码的技术。这种技术可以让我们编写出更加灵活、可复用的代码。

rust中的范型使用`<>`来定义，如下所示：

```rust
fn largest<T>(list: &[T]) -> T {
    let mut largest = list[0];

    for &item in list.iter() {
        if item > largest {
            largest = item;
        }
    }

    largest
}
```

在这个例子中，`T`是一个类型参数，它可以是任何类型。这个函数接收一个`&[T]`类型的参数，并返回一个`T`类型的值。

## 无继承

rust中没有继承的概念，但是可以使用`trait`来实现类似继承的功能。

`trait`是一种定义共享行为的方法，它可以被多个类型实现。下面是一个简单的例子：

```rust
trait Animal {
    fn speak(&self);
}

struct Dog;

impl Animal for Dog {
    fn speak(&self) {
        println!("Dog says: Woof!");
    }
}

struct Cat;

impl Animal for Cat {
    fn speak(&self) {
        println!("Cat says: Meow!");
    }
}

fn main() {
    let dog = Dog;
    let cat = Cat;

    dog.speak();
    cat.speak();
}
```
