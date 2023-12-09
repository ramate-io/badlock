; ModuleID = 'single_mock_deadlock.39cc3f8a-cgu.0'
source_filename = "single_mock_deadlock.39cc3f8a-cgu.0"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

@vtable.0 = private unnamed_addr constant <{ ptr, [16 x i8], ptr, ptr, ptr }> <{ ptr @"_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h644bc1ef97ee45beE", [16 x i8] c"\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17hf891983067087f90E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h2545bb9cd33d8d58E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h2545bb9cd33d8d58E" }>, align 8
@alloc_5b1007590709098660a9536c0a055b62 = private unnamed_addr constant <{ [30 x i8] }> <{ [30 x i8] c"./test/single_mock_deadlock.rs" }>, align 1
@alloc_74809dc4b32e97ec0a17b7dcb2eb273c = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_5b1007590709098660a9536c0a055b62, [16 x i8] c"\1E\00\00\00\00\00\00\00\18\00\00\00\0D\00\00\00" }>, align 8
@str.1 = internal constant [28 x i8] c"attempt to add with overflow"
@alloc_2f6b2afdba02113e58e28790f514e9df = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_5b1007590709098660a9536c0a055b62, [16 x i8] c"\1E\00\00\00\00\00\00\00!\00\00\00\0D\00\00\00" }>, align 8
@str.2 = internal constant [33 x i8] c"attempt to multiply with overflow"

; std::sys_common::backtrace::__rust_begin_short_backtrace
; Function Attrs: noinline nonlazybind uwtable
define internal void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h806649b0f02f3dd3E(ptr %f) unnamed_addr #0 {
start:
; call core::ops::function::FnOnce::call_once
  call void @_ZN4core3ops8function6FnOnce9call_once17h87b64afcb7816265E(ptr %f)
  call void asm sideeffect "", "~{memory}"(), !srcloc !3
  ret void
}

; std::rt::lang_start
; Function Attrs: nonlazybind uwtable
define hidden i64 @_ZN3std2rt10lang_start17h3a0fc5ee59e52477E(ptr %main, i64 %argc, ptr %argv, i8 %sigpipe) unnamed_addr #1 {
start:
  %_8 = alloca ptr, align 8
  %_5 = alloca i64, align 8
  store ptr %main, ptr %_8, align 8
; call std::rt::lang_start_internal
  %0 = call i64 @_ZN3std2rt19lang_start_internal17ha24935c91c6c3a61E(ptr align 1 %_8, ptr align 8 @vtable.0, i64 %argc, ptr %argv, i8 %sigpipe)
  store i64 %0, ptr %_5, align 8
  %1 = load i64, ptr %_5, align 8, !noundef !4
  ret i64 %1
}

; std::rt::lang_start::{{closure}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h2545bb9cd33d8d58E"(ptr align 8 %_1) unnamed_addr #2 {
start:
  %self = alloca i8, align 1
  %_4 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
; call std::sys_common::backtrace::__rust_begin_short_backtrace
  call void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h806649b0f02f3dd3E(ptr %_4)
; call <() as std::process::Termination>::report
  %0 = call i8 @"_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h06e3637513e73b47E"()
  store i8 %0, ptr %self, align 1
  %_6 = load i8, ptr %self, align 1, !noundef !4
  %1 = zext i8 %_6 to i32
  ret i32 %1
}

; core::ops::function::FnOnce::call_once{{vtable.shim}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal i32 @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17hf891983067087f90E"(ptr %_1) unnamed_addr #2 {
start:
  %_2 = alloca {}, align 1
  %0 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
; call core::ops::function::FnOnce::call_once
  %1 = call i32 @_ZN4core3ops8function6FnOnce9call_once17h5adcd0563cd3e510E(ptr %0)
  ret i32 %1
}

; core::ops::function::FnOnce::call_once
; Function Attrs: inlinehint nonlazybind uwtable
define internal i32 @_ZN4core3ops8function6FnOnce9call_once17h5adcd0563cd3e510E(ptr %0) unnamed_addr #2 personality ptr @rust_eh_personality {
start:
  %1 = alloca { ptr, i32 }, align 8
  %_2 = alloca {}, align 1
  %_1 = alloca ptr, align 8
  store ptr %0, ptr %_1, align 8
; invoke std::rt::lang_start::{{closure}}
  %2 = invoke i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h2545bb9cd33d8d58E"(ptr align 8 %_1)
          to label %bb1 unwind label %cleanup

bb3:                                              ; preds = %cleanup
  %3 = load ptr, ptr %1, align 8, !noundef !4
  %4 = getelementptr inbounds { ptr, i32 }, ptr %1, i32 0, i32 1
  %5 = load i32, ptr %4, align 8, !noundef !4
  %6 = insertvalue { ptr, i32 } poison, ptr %3, 0
  %7 = insertvalue { ptr, i32 } %6, i32 %5, 1
  resume { ptr, i32 } %7

cleanup:                                          ; preds = %start
  %8 = landingpad { ptr, i32 }
          cleanup
  %9 = extractvalue { ptr, i32 } %8, 0
  %10 = extractvalue { ptr, i32 } %8, 1
  %11 = getelementptr inbounds { ptr, i32 }, ptr %1, i32 0, i32 0
  store ptr %9, ptr %11, align 8
  %12 = getelementptr inbounds { ptr, i32 }, ptr %1, i32 0, i32 1
  store i32 %10, ptr %12, align 8
  br label %bb3

bb1:                                              ; preds = %start
  ret i32 %2
}

; core::ops::function::FnOnce::call_once
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @_ZN4core3ops8function6FnOnce9call_once17h87b64afcb7816265E(ptr %_1) unnamed_addr #2 {
start:
  %_2 = alloca {}, align 1
  call void %_1()
  ret void
}

; core::ptr::drop_in_place<std::rt::lang_start<()>::{{closure}}>
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @"_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h644bc1ef97ee45beE"(ptr %_1) unnamed_addr #2 {
start:
  ret void
}

; <() as std::process::Termination>::report
; Function Attrs: inlinehint nonlazybind uwtable
define internal i8 @"_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h06e3637513e73b47E"() unnamed_addr #2 {
start:
  ret i8 0
}

; single_mock_deadlock::acquire_lock
; Function Attrs: noinline nonlazybind uwtable
define internal void @_ZN20single_mock_deadlock12acquire_lock17h23427a54f7280930E(ptr align 8 %x) unnamed_addr #0 {
start:
  call void @_acquire_lock(ptr align 8 %x)
  ret void
}

; single_mock_deadlock::release_lock
; Function Attrs: noinline nonlazybind uwtable
define internal void @_ZN20single_mock_deadlock12release_lock17h9549d935d34b31c7E(ptr align 8 %x) unnamed_addr #0 {
start:
  call void @_release_lock(ptr align 8 %x)
  ret void
}

; single_mock_deadlock::locks
; Function Attrs: nonlazybind uwtable
define internal void @_ZN20single_mock_deadlock5locks17h9dea92cc39a24f28E(ptr align 8 %x) unnamed_addr #1 {
start:
; call single_mock_deadlock::acquire_lock
  call void @_ZN20single_mock_deadlock12acquire_lock17h23427a54f7280930E(ptr align 8 %x)
  %0 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 0, i32 3)
  %_5.0 = extractvalue { i32, i1 } %0, 0
  %_5.1 = extractvalue { i32, i1 } %0, 1
  %1 = call i1 @llvm.expect.i1(i1 %_5.1, i1 false)
  br i1 %1, label %panic, label %bb2

bb2:                                              ; preds = %start
; call single_mock_deadlock::release_lock
  call void @_ZN20single_mock_deadlock12release_lock17h9549d935d34b31c7E(ptr align 8 %x)
  ret void

panic:                                            ; preds = %start
; call core::panicking::panic
  call void @_ZN4core9panicking5panic17h39466a6143e26d57E(ptr align 1 @str.1, i64 28, ptr align 8 @alloc_74809dc4b32e97ec0a17b7dcb2eb273c) #7
  unreachable
}

; single_mock_deadlock::deadlocks
; Function Attrs: nonlazybind uwtable
define internal void @_ZN20single_mock_deadlock9deadlocks17h817bc3206565efd5E(ptr align 8 %x) unnamed_addr #1 {
start:
; call single_mock_deadlock::acquire_lock
  call void @_ZN20single_mock_deadlock12acquire_lock17h23427a54f7280930E(ptr align 8 %x)
  %0 = call { i32, i1 } @llvm.smul.with.overflow.i32(i32 3, i32 1)
  %_5.0 = extractvalue { i32, i1 } %0, 0
  %_5.1 = extractvalue { i32, i1 } %0, 1
  %1 = call i1 @llvm.expect.i1(i1 %_5.1, i1 false)
  br i1 %1, label %panic, label %bb2

bb2:                                              ; preds = %start
; call single_mock_deadlock::locks
  call void @_ZN20single_mock_deadlock5locks17h9dea92cc39a24f28E(ptr align 8 %x)
; call single_mock_deadlock::release_lock
  call void @_ZN20single_mock_deadlock12release_lock17h9549d935d34b31c7E(ptr align 8 %x)
  ret void

panic:                                            ; preds = %start
; call core::panicking::panic
  call void @_ZN4core9panicking5panic17h39466a6143e26d57E(ptr align 1 @str.2, i64 33, ptr align 8 @alloc_2f6b2afdba02113e58e28790f514e9df) #7
  unreachable
}

; single_mock_deadlock::main
; Function Attrs: nonlazybind uwtable
define internal void @_ZN20single_mock_deadlock4main17h044f1edf8c879015E() unnamed_addr #1 {
start:
  %x = alloca i64, align 8
  store i64 64, ptr %x, align 8
; call single_mock_deadlock::deadlocks
  call void @_ZN20single_mock_deadlock9deadlocks17h817bc3206565efd5E(ptr align 8 %x)
  ret void
}

; std::rt::lang_start_internal
; Function Attrs: nonlazybind uwtable
declare i64 @_ZN3std2rt19lang_start_internal17ha24935c91c6c3a61E(ptr align 1, ptr align 8, i64, ptr, i8) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare i32 @rust_eh_personality(i32, i32, i64, ptr, ptr) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare void @_acquire_lock(ptr align 8) unnamed_addr #1

; Function Attrs: nonlazybind uwtable
declare void @_release_lock(ptr align 8) unnamed_addr #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i32, i1 } @llvm.sadd.with.overflow.i32(i32, i32) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i1 @llvm.expect.i1(i1, i1) #4

; core::panicking::panic
; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core9panicking5panic17h39466a6143e26d57E(ptr align 1, i64, ptr align 8) unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i32, i1 } @llvm.smul.with.overflow.i32(i32, i32) #3

; Function Attrs: nonlazybind
define i32 @main(i32 %0, ptr %1) unnamed_addr #6 {
top:
  %2 = sext i32 %0 to i64
; call std::rt::lang_start
  %3 = call i64 @_ZN3std2rt10lang_start17h3a0fc5ee59e52477E(ptr @_ZN20single_mock_deadlock4main17h044f1edf8c879015E, i64 %2, ptr %1, i8 0)
  %4 = trunc i64 %3 to i32
  ret i32 %4
}

attributes #0 = { noinline nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #1 = { nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #2 = { inlinehint nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #5 = { cold noinline noreturn nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #6 = { nonlazybind "target-cpu"="generic" }
attributes #7 = { noreturn }

!llvm.module.flags = !{!0, !1, !2}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 7, !"PIE Level", i32 2}
!2 = !{i32 2, !"RtLibUseGOT", i32 1}
!3 = !{i32 1204749}
!4 = !{}
