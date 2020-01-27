; ModuleID = 'Module'
source_filename = "Module"
target triple = "x86_64-apple-darwin18.7.0"

%struct._opaque_pthread_t = type opaque
%Foo = type { i32, i32, i32 }

declare i32 @pthread_create(%struct._opaque_pthread_t*, i8*, i8* (i8*)*, i8*)

declare i32 @pthread_join(%struct._opaque_pthread_t*, i8**)

define i32 @f(i32) {
entry:
  %x = alloca i32
  store i32 %0, i32* %x
  %1 = load i32, i32* %x
  ret i32 %1
}

define i32 @main() {
entry:
  %_var_x0 = alloca %Foo
  %Foo = alloca %Foo
  %0 = getelementptr inbounds %Foo, %Foo* %Foo, i32 0, i32 0
  store i32 5, i32* %0
  %1 = load %Foo, %Foo* %Foo
  store %Foo %1, %Foo* %_var_x0
  %pthread = alloca %struct._opaque_pthread_t
  %2 = call i32 @pthread_create(%struct._opaque_pthread_t* %pthread, i8* null, i8* (i8*)* @_async0, i8* null)
  %pthread1 = alloca %struct._opaque_pthread_t
  %3 = call i32 @pthread_create(%struct._opaque_pthread_t* %pthread1, i8* null, i8* (i8*)* @_async1, i8* null)
  %4 = load %Foo, %Foo* %_var_x0
  %5 = call i32 @pthread_join(%struct._opaque_pthread_t* %pthread, i8** null)
  %6 = call i32 @pthread_join(%struct._opaque_pthread_t* %pthread1, i8** null)
  ret i32 0
}

define i8* @_async0(i8*) {
entry:
  %1 = call i32 @f(i32 5)
  ret i8* null
}

define i8* @_async1(i8*) {
entry:
  %_var_w0 = alloca %Foo
  %Foo = alloca %Foo
  %1 = getelementptr inbounds %Foo, %Foo* %Foo, i32 0, i32 1
  store i32 5, i32* %1
  %2 = load %Foo, %Foo* %Foo
  store %Foo %2, %Foo* %_var_w0
  %3 = getelementptr inbounds %Foo, %Foo* %_var_w0, i32 0, i32 0
  store i32 5, i32* %3
  ret i8* null
}