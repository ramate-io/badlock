; ModuleID = 'locks_no_deadlock.9b680bd8-cgu.0'
source_filename = "locks_no_deadlock.9b680bd8-cgu.0"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%"core::sync::atomic::AtomicUsize" = type { i64 }
%"std::sync::mutex::Mutex<i32>" = type { %"std::sys::unix::locks::futex_mutex::Mutex", %"std::sync::poison::Flag", [3 x i8], i32 }
%"std::sys::unix::locks::futex_mutex::Mutex" = type { %"core::sync::atomic::AtomicU32" }
%"core::sync::atomic::AtomicU32" = type { i32 }
%"std::sync::poison::Flag" = type { %"core::sync::atomic::AtomicBool" }
%"core::sync::atomic::AtomicBool" = type { i8 }
%"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>" = type { i64, [2 x i64] }
%"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>::Ok" = type { [1 x i64], { ptr, i8 } }
%"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>::Err" = type { [1 x i64], { ptr, i8 } }
%"core::fmt::Arguments<'_>" = type { { ptr, i64 }, { ptr, i64 }, { ptr, i64 } }
%"core::fmt::builders::DebugStruct<'_, '_>" = type { ptr, i8, i8, [6 x i8] }

@vtable.0 = private unnamed_addr constant <{ ptr, [16 x i8], ptr, ptr, ptr }> <{ ptr @"_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hd8cbafddca2b9641E", [16 x i8] c"\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h65e4c206f9429665E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h5b1b8bd09094ae34E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h5b1b8bd09094ae34E" }>, align 8
@_ZN3std9panicking11panic_count18GLOBAL_PANIC_COUNT17hd8bdcf533dbffa86E = external global %"core::sync::atomic::AtomicUsize"
@alloc_91c7fa63c3cfeaa3c795652d5cf060e4 = private unnamed_addr constant <{ [12 x i8] }> <{ [12 x i8] c"invalid args" }>, align 1
@alloc_560206a49c61adca6f3f0639a12632eb = private unnamed_addr constant <{ ptr, [8 x i8] }> <{ ptr @alloc_91c7fa63c3cfeaa3c795652d5cf060e4, [8 x i8] c"\0C\00\00\00\00\00\00\00" }>, align 8
@alloc_0f3d7beb2672f296d76a42c95890bef9 = private unnamed_addr constant <{ [75 x i8] }> <{ [75 x i8] c"/rustc/90c541806f23a127002de5b4038be731ba1458ca/library/core/src/fmt/mod.rs" }>, align 1
@alloc_ea676e06474b3ad20dc2b78cc1c22fa8 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_0f3d7beb2672f296d76a42c95890bef9, [16 x i8] c"K\00\00\00\00\00\00\00\9E\01\00\00\0D\00\00\00" }>, align 8
@alloc_584d991c255ecc0b9a8eb25813e7c09e = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_0f3d7beb2672f296d76a42c95890bef9, [16 x i8] c"K\00\00\00\00\00\00\00\91\01\00\00\0D\00\00\00" }>, align 8
@alloc_513570631223a12912d85da2bec3b15a = private unnamed_addr constant <{}> zeroinitializer, align 8
@alloc_96ab912d0054b46da785b206a96c9a45 = private unnamed_addr constant <{ [49 x i8] }> <{ [49 x i8] c"there is no such thing as an acquire-release load" }>, align 1
@alloc_e1829842c862d95248bdb87a26e1372f = private unnamed_addr constant <{ ptr, [8 x i8] }> <{ ptr @alloc_96ab912d0054b46da785b206a96c9a45, [8 x i8] c"1\00\00\00\00\00\00\00" }>, align 8
@alloc_54bd2c6f8f6357e786e7d7879fa4cb61 = private unnamed_addr constant <{ [79 x i8] }> <{ [79 x i8] c"/rustc/90c541806f23a127002de5b4038be731ba1458ca/library/core/src/sync/atomic.rs" }>, align 1
@alloc_dd9d57512755e6660f09fe57446bf051 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_54bd2c6f8f6357e786e7d7879fa4cb61, [16 x i8] c"O\00\00\00\00\00\00\00[\0C\00\00\17\00\00\00" }>, align 8
@alloc_9cd20c3e415f4d39f0ceb012cb758628 = private unnamed_addr constant <{ [40 x i8] }> <{ [40 x i8] c"there is no such thing as a release load" }>, align 1
@alloc_c986ce739acfc2550367c92bb47d7476 = private unnamed_addr constant <{ ptr, [8 x i8] }> <{ ptr @alloc_9cd20c3e415f4d39f0ceb012cb758628, [8 x i8] c"(\00\00\00\00\00\00\00" }>, align 8
@alloc_86d4430040752d585b931e9d5bb1491d = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_54bd2c6f8f6357e786e7d7879fa4cb61, [16 x i8] c"O\00\00\00\00\00\00\00Z\0C\00\00\18\00\00\00" }>, align 8
@alloc_00c0bce0fa6327f8ec8e69d6d765d508 = private unnamed_addr constant <{ [50 x i8] }> <{ [50 x i8] c"there is no such thing as an acquire-release store" }>, align 1
@alloc_e8a173a411485b7e37220624c537a890 = private unnamed_addr constant <{ ptr, [8 x i8] }> <{ ptr @alloc_00c0bce0fa6327f8ec8e69d6d765d508, [8 x i8] c"2\00\00\00\00\00\00\00" }>, align 8
@alloc_3eee851da11e7f3ecded4ef69bb02c20 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_54bd2c6f8f6357e786e7d7879fa4cb61, [16 x i8] c"O\00\00\00\00\00\00\00L\0C\00\00\17\00\00\00" }>, align 8
@alloc_bf39103a6db665396aab4632362d9353 = private unnamed_addr constant <{ [42 x i8] }> <{ [42 x i8] c"there is no such thing as an acquire store" }>, align 1
@alloc_a5cc7fc528e53ce267236c14ebed42c5 = private unnamed_addr constant <{ ptr, [8 x i8] }> <{ ptr @alloc_bf39103a6db665396aab4632362d9353, [8 x i8] c"*\00\00\00\00\00\00\00" }>, align 8
@alloc_14a783c8722e23b13f162efb02239a83 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_54bd2c6f8f6357e786e7d7879fa4cb61, [16 x i8] c"O\00\00\00\00\00\00\00K\0C\00\00\18\00\00\00" }>, align 8
@alloc_7adef5546d83b439c7829602020737c6 = private unnamed_addr constant <{ [61 x i8] }> <{ [61 x i8] c"there is no such thing as an acquire-release failure ordering" }>, align 1
@alloc_53963eedc63e9e4352c653ec571ba638 = private unnamed_addr constant <{ ptr, [8 x i8] }> <{ ptr @alloc_7adef5546d83b439c7829602020737c6, [8 x i8] c"=\00\00\00\00\00\00\00" }>, align 8
@alloc_2feb807b751aebf34c93b8589ebd6a4c = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_54bd2c6f8f6357e786e7d7879fa4cb61, [16 x i8] c"O\00\00\00\00\00\00\00\AE\0C\00\00\1C\00\00\00" }>, align 8
@alloc_5a43f8d94dd4505c1dba43832ce73af8 = private unnamed_addr constant <{ [52 x i8] }> <{ [52 x i8] c"there is no such thing as a release failure ordering" }>, align 1
@alloc_406c3ccfb949c60617508c1453ca62ba = private unnamed_addr constant <{ ptr, [8 x i8] }> <{ ptr @alloc_5a43f8d94dd4505c1dba43832ce73af8, [8 x i8] c"4\00\00\00\00\00\00\00" }>, align 8
@alloc_5b75a3d48c4b4b0a1bfc1734af871388 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_54bd2c6f8f6357e786e7d7879fa4cb61, [16 x i8] c"O\00\00\00\00\00\00\00\AF\0C\00\00\1D\00\00\00" }>, align 8
@alloc_00ae4b301f7fab8ac9617c03fcbd7274 = private unnamed_addr constant <{ [43 x i8] }> <{ [43 x i8] c"called `Result::unwrap()` on an `Err` value" }>, align 1
@vtable.1 = private unnamed_addr constant <{ ptr, [16 x i8], ptr }> <{ ptr @"_ZN4core3ptr98drop_in_place$LT$std..sync..poison..PoisonError$LT$std..sync..mutex..MutexGuard$LT$i32$GT$$GT$$GT$17hdeec11bbf1c42d0fE", [16 x i8] c"\10\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN76_$LT$std..sync..poison..PoisonError$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h3d3b2be080f6ef92E" }>, align 8
@alloc_8e2410b80645266732854088d21653bc = private unnamed_addr constant <{ [11 x i8] }> <{ [11 x i8] c"PoisonError" }>, align 1
@alloc_a54634eca57d99cd4de6bfa84031f82d = private unnamed_addr constant <{ [27 x i8] }> <{ [27 x i8] c"./test/locks_no_deadlock.rs" }>, align 1
@alloc_45e6fd4830bcb5aa3cc478bb3b66db88 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_a54634eca57d99cd4de6bfa84031f82d, [16 x i8] c"\1B\00\00\00\00\00\00\00\09\00\00\00'\00\00\00" }>, align 8
@alloc_c52fd7a625898b5aee71f907f580e7b5 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_a54634eca57d99cd4de6bfa84031f82d, [16 x i8] c"\1B\00\00\00\00\00\00\00\0A\00\00\00\09\00\00\00" }>, align 8
@str.2 = internal constant [28 x i8] c"attempt to add with overflow"
@alloc_ea497d8b8a597918be23bdaa96fae024 = private unnamed_addr constant <{ [16 x i8] }> <{ [16 x i8] c"Here is fine x: " }>, align 1
@alloc_49a1e817e911805af64bbc7efb390101 = private unnamed_addr constant <{ [1 x i8] }> <{ [1 x i8] c"\0A" }>, align 1
@alloc_57f302b174bab2721e64f70b64e905fe = private unnamed_addr constant <{ ptr, [8 x i8], ptr, [8 x i8] }> <{ ptr @alloc_ea497d8b8a597918be23bdaa96fae024, [8 x i8] c"\10\00\00\00\00\00\00\00", ptr @alloc_49a1e817e911805af64bbc7efb390101, [8 x i8] c"\01\00\00\00\00\00\00\00" }>, align 8
@alloc_06f8f80e64cdaf436bd4cc94d17b0da4 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_a54634eca57d99cd4de6bfa84031f82d, [16 x i8] c"\1B\00\00\00\00\00\00\00\0F\00\00\00-\00\00\00" }>, align 8
@alloc_b4883070d3fe8f66aa6794d613ff23cf = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_a54634eca57d99cd4de6bfa84031f82d, [16 x i8] c"\1B\00\00\00\00\00\00\00\10\00\00\00\09\00\00\00" }>, align 8
@alloc_1818f374d478ff08aaba0ee9fab2b898 = private unnamed_addr constant <{ [24 x i8] }> <{ [24 x i8] c"Should also get here x: " }>, align 1
@alloc_6c0b352bf037327c8a6344d3eb82ea55 = private unnamed_addr constant <{ ptr, [8 x i8], ptr, [8 x i8] }> <{ ptr @alloc_1818f374d478ff08aaba0ee9fab2b898, [8 x i8] c"\18\00\00\00\00\00\00\00", ptr @alloc_49a1e817e911805af64bbc7efb390101, [8 x i8] c"\01\00\00\00\00\00\00\00" }>, align 8

; std::sys_common::backtrace::__rust_begin_short_backtrace
; Function Attrs: noinline nonlazybind uwtable
define internal void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h3b9572c5fdde32f0E(ptr %f) unnamed_addr #0 {
start:
; call core::ops::function::FnOnce::call_once
  call void @_ZN4core3ops8function6FnOnce9call_once17h81c93097912e68aaE(ptr %f)
  call void asm sideeffect "", "~{memory}"(), !srcloc !3
  ret void
}

; std::rt::lang_start
; Function Attrs: nonlazybind uwtable
define hidden i64 @_ZN3std2rt10lang_start17h320d0e6e2a6b7c06E(ptr %main, i64 %argc, ptr %argv, i8 %sigpipe) unnamed_addr #1 {
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
define internal i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h5b1b8bd09094ae34E"(ptr align 8 %_1) unnamed_addr #2 {
start:
  %self = alloca i8, align 1
  %_4 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
; call std::sys_common::backtrace::__rust_begin_short_backtrace
  call void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h3b9572c5fdde32f0E(ptr %_4)
; call <() as std::process::Termination>::report
  %0 = call i8 @"_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h6370ea2f9d98ae59E"()
  store i8 %0, ptr %self, align 1
  %_6 = load i8, ptr %self, align 1, !noundef !4
  %1 = zext i8 %_6 to i32
  ret i32 %1
}

; std::sys::unix::locks::futex_mutex::Mutex::lock
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @_ZN3std3sys4unix5locks11futex_mutex5Mutex4lock17hac6ea930e6aedc46E(ptr align 4 %self) unnamed_addr #2 {
start:
  %_15 = alloca i8, align 1
  %_4 = alloca { i32, i32 }, align 4
; call core::sync::atomic::atomic_compare_exchange
  %0 = call { i32, i32 } @_ZN4core4sync6atomic23atomic_compare_exchange17h8404968de7b5a457E(ptr %self, i32 0, i32 1, i8 2, i8 0)
  store { i32, i32 } %0, ptr %_4, align 4
  %1 = load i32, ptr %_4, align 4, !range !5, !noundef !4
  %_16 = zext i32 %1 to i64
  %2 = icmp eq i64 %_16, 0
  br i1 %2, label %bb6, label %bb5

bb6:                                              ; preds = %start
  store i8 1, ptr %_15, align 1
  br label %bb4

bb5:                                              ; preds = %start
  store i8 0, ptr %_15, align 1
  br label %bb4

bb4:                                              ; preds = %bb6, %bb5
  %3 = load i8, ptr %_15, align 1, !range !6, !noundef !4
  %4 = trunc i8 %3 to i1
  %_2 = xor i1 %4, true
  br i1 %_2, label %bb1, label %bb2

bb2:                                              ; preds = %bb1, %bb4
  ret void

bb1:                                              ; preds = %bb4
; call std::sys::unix::locks::futex_mutex::Mutex::lock_contended
  call void @_ZN3std3sys4unix5locks11futex_mutex5Mutex14lock_contended17hdc3d388df0205cf0E(ptr align 4 %self)
  br label %bb2
}

; std::sync::mutex::Mutex<T>::new
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @"_ZN3std4sync5mutex14Mutex$LT$T$GT$3new17h6c6ef35e6eaf06b7E"(ptr sret(%"std::sync::mutex::Mutex<i32>") %0, i32 %t) unnamed_addr #2 {
start:
  %_8 = alloca %"core::sync::atomic::AtomicBool", align 1
  %_5 = alloca %"core::sync::atomic::AtomicU32", align 4
  %_4 = alloca i32, align 4
  %_3 = alloca %"std::sync::poison::Flag", align 1
  %_2 = alloca %"std::sys::unix::locks::futex_mutex::Mutex", align 4
  store i32 0, ptr %_5, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %_2, ptr align 4 %_5, i64 4, i1 false)
  store i8 0, ptr %_8, align 1
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %_3, ptr align 1 %_8, i64 1, i1 false)
  store i32 %t, ptr %_4, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %0, ptr align 4 %_2, i64 4, i1 false)
  %1 = getelementptr inbounds %"std::sync::mutex::Mutex<i32>", ptr %0, i32 0, i32 1
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %1, ptr align 1 %_3, i64 1, i1 false)
  %2 = load i32, ptr %_4, align 4, !noundef !4
  %3 = getelementptr inbounds %"std::sync::mutex::Mutex<i32>", ptr %0, i32 0, i32 3
  store i32 %2, ptr %3, align 4
  ret void
}

; std::sync::mutex::Mutex<T>::lock
; Function Attrs: nonlazybind uwtable
define internal void @"_ZN3std4sync5mutex14Mutex$LT$T$GT$4lock17h658da0fccc909ca3E"(ptr sret(%"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>") %0, ptr align 4 %self) unnamed_addr #1 {
start:
; call std::sys::unix::locks::futex_mutex::Mutex::lock
  call void @_ZN3std3sys4unix5locks11futex_mutex5Mutex4lock17hac6ea930e6aedc46E(ptr align 4 %self)
; call std::sync::mutex::MutexGuard<T>::new
  call void @"_ZN3std4sync5mutex19MutexGuard$LT$T$GT$3new17h2d24539e20ebb8a7E"(ptr sret(%"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>") %0, ptr align 4 %self)
  ret void
}

; std::sync::mutex::MutexGuard<T>::new
; Function Attrs: nonlazybind uwtable
define internal void @"_ZN3std4sync5mutex19MutexGuard$LT$T$GT$3new17h2d24539e20ebb8a7E"(ptr sret(%"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>") %0, ptr align 4 %lock) unnamed_addr #1 {
start:
  %_4 = alloca ptr, align 8
  %_3 = getelementptr inbounds %"std::sync::mutex::Mutex<i32>", ptr %lock, i32 0, i32 1
; call std::sync::poison::Flag::guard
  %1 = call { i8, i8 } @_ZN3std4sync6poison4Flag5guard17hcbe2af90a557f7cfE(ptr align 1 %_3)
  %2 = extractvalue { i8, i8 } %1, 0
  %_2.0 = trunc i8 %2 to i1
  %_2.1 = extractvalue { i8, i8 } %1, 1
  store ptr %lock, ptr %_4, align 8
  %3 = load ptr, ptr %_4, align 8, !nonnull !4, !align !7, !noundef !4
; call std::sync::poison::map_result
  call void @_ZN3std4sync6poison10map_result17h90fa49978eac72edE(ptr sret(%"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>") %0, i1 zeroext %_2.0, i8 %_2.1, ptr align 4 %3)
  ret void
}

; std::sync::mutex::MutexGuard<T>::new::{{closure}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal { ptr, i8 } @"_ZN3std4sync5mutex19MutexGuard$LT$T$GT$3new28_$u7b$$u7b$closure$u7d$$u7d$17hf6b19cfcb5b9397bE"(ptr align 4 %0, i1 zeroext %guard) unnamed_addr #2 {
start:
  %1 = alloca { ptr, i8 }, align 8
  %_1 = alloca ptr, align 8
  store ptr %0, ptr %_1, align 8
  %_3 = load ptr, ptr %_1, align 8, !nonnull !4, !align !7, !noundef !4
  store ptr %_3, ptr %1, align 8
  %2 = getelementptr inbounds { ptr, i8 }, ptr %1, i32 0, i32 1
  %3 = zext i1 %guard to i8
  store i8 %3, ptr %2, align 8
  %4 = getelementptr inbounds { ptr, i8 }, ptr %1, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8, !nonnull !4, !align !7, !noundef !4
  %6 = getelementptr inbounds { ptr, i8 }, ptr %1, i32 0, i32 1
  %7 = load i8, ptr %6, align 8, !range !6, !noundef !4
  %8 = trunc i8 %7 to i1
  %9 = zext i1 %8 to i8
  %10 = insertvalue { ptr, i8 } poison, ptr %5, 0
  %11 = insertvalue { ptr, i8 } %10, i8 %9, 1
  ret { ptr, i8 } %11
}

; std::sync::poison::map_result
; Function Attrs: nonlazybind uwtable
define internal void @_ZN3std4sync6poison10map_result17h90fa49978eac72edE(ptr sret(%"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>") %0, i1 zeroext %1, i8 %2, ptr align 4 %f) unnamed_addr #1 {
start:
  %_10 = alloca i8, align 1
  %_6 = alloca i8, align 1
  %result = alloca { i8, i8 }, align 1
  %3 = getelementptr inbounds { i8, i8 }, ptr %result, i32 0, i32 0
  %4 = zext i1 %1 to i8
  store i8 %4, ptr %3, align 1
  %5 = getelementptr inbounds { i8, i8 }, ptr %result, i32 0, i32 1
  store i8 %2, ptr %5, align 1
  %6 = load i8, ptr %result, align 1, !range !6, !noundef !4
  %7 = trunc i8 %6 to i1
  %_3 = zext i1 %7 to i64
  %8 = icmp eq i64 %_3, 0
  br i1 %8, label %bb3, label %bb1

bb3:                                              ; preds = %start
  %9 = getelementptr inbounds { i8, i8 }, ptr %result, i32 0, i32 1
  %10 = load i8, ptr %9, align 1, !range !6, !noundef !4
  %t = trunc i8 %10 to i1
  %11 = zext i1 %t to i8
  store i8 %11, ptr %_6, align 1
  %12 = load i8, ptr %_6, align 1, !range !6, !noundef !4
  %13 = trunc i8 %12 to i1
; call std::sync::mutex::MutexGuard<T>::new::{{closure}}
  %14 = call { ptr, i8 } @"_ZN3std4sync5mutex19MutexGuard$LT$T$GT$3new28_$u7b$$u7b$closure$u7d$$u7d$17hf6b19cfcb5b9397bE"(ptr align 4 %f, i1 zeroext %13)
  %_5.0 = extractvalue { ptr, i8 } %14, 0
  %15 = extractvalue { ptr, i8 } %14, 1
  %_5.1 = trunc i8 %15 to i1
  %16 = getelementptr inbounds %"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>::Ok", ptr %0, i32 0, i32 1
  %17 = getelementptr inbounds { ptr, i8 }, ptr %16, i32 0, i32 0
  store ptr %_5.0, ptr %17, align 8
  %18 = getelementptr inbounds { ptr, i8 }, ptr %16, i32 0, i32 1
  %19 = zext i1 %_5.1 to i8
  store i8 %19, ptr %18, align 8
  store i64 0, ptr %0, align 8
  br label %bb7

bb1:                                              ; preds = %start
  %20 = getelementptr inbounds { i8, i8 }, ptr %result, i32 0, i32 1
  %21 = load i8, ptr %20, align 1, !range !6, !noundef !4
  %guard = trunc i8 %21 to i1
  %22 = zext i1 %guard to i8
  store i8 %22, ptr %_10, align 1
  %23 = load i8, ptr %_10, align 1, !range !6, !noundef !4
  %24 = trunc i8 %23 to i1
; call std::sync::mutex::MutexGuard<T>::new::{{closure}}
  %25 = call { ptr, i8 } @"_ZN3std4sync5mutex19MutexGuard$LT$T$GT$3new28_$u7b$$u7b$closure$u7d$$u7d$17hf6b19cfcb5b9397bE"(ptr align 4 %f, i1 zeroext %24)
  %_9.0 = extractvalue { ptr, i8 } %25, 0
  %26 = extractvalue { ptr, i8 } %25, 1
  %_9.1 = trunc i8 %26 to i1
; call std::sync::poison::PoisonError<T>::new
  %27 = call { ptr, i8 } @"_ZN3std4sync6poison20PoisonError$LT$T$GT$3new17h47d711a0e133af9dE"(ptr align 4 %_9.0, i1 zeroext %_9.1)
  %_8.0 = extractvalue { ptr, i8 } %27, 0
  %28 = extractvalue { ptr, i8 } %27, 1
  %_8.1 = trunc i8 %28 to i1
  %29 = getelementptr inbounds %"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>::Err", ptr %0, i32 0, i32 1
  %30 = getelementptr inbounds { ptr, i8 }, ptr %29, i32 0, i32 0
  store ptr %_8.0, ptr %30, align 8
  %31 = getelementptr inbounds { ptr, i8 }, ptr %29, i32 0, i32 1
  %32 = zext i1 %_8.1 to i8
  store i8 %32, ptr %31, align 8
  store i64 1, ptr %0, align 8
  br label %bb7

bb2:                                              ; No predecessors!
  unreachable

bb7:                                              ; preds = %bb3, %bb1
  ret void
}

; std::sync::poison::PoisonError<T>::new
; Function Attrs: nonlazybind uwtable
define internal { ptr, i8 } @"_ZN3std4sync6poison20PoisonError$LT$T$GT$3new17h47d711a0e133af9dE"(ptr align 4 %guard.0, i1 zeroext %guard.1) unnamed_addr #1 {
start:
  %0 = alloca { ptr, i8 }, align 8
  %1 = getelementptr inbounds { ptr, i8 }, ptr %0, i32 0, i32 0
  store ptr %guard.0, ptr %1, align 8
  %2 = getelementptr inbounds { ptr, i8 }, ptr %0, i32 0, i32 1
  %3 = zext i1 %guard.1 to i8
  store i8 %3, ptr %2, align 8
  %4 = getelementptr inbounds { ptr, i8 }, ptr %0, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8, !nonnull !4, !align !7, !noundef !4
  %6 = getelementptr inbounds { ptr, i8 }, ptr %0, i32 0, i32 1
  %7 = load i8, ptr %6, align 8, !range !6, !noundef !4
  %8 = trunc i8 %7 to i1
  %9 = zext i1 %8 to i8
  %10 = insertvalue { ptr, i8 } poison, ptr %5, 0
  %11 = insertvalue { ptr, i8 } %10, i8 %9, 1
  ret { ptr, i8 } %11
}

; std::sync::poison::PoisonError<T>::new
; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN3std4sync6poison20PoisonError$LT$T$GT$3new17h625bbd3cff7c0439E"(i1 zeroext %guard) unnamed_addr #1 {
start:
  %0 = alloca i8, align 1
  %1 = zext i1 %guard to i8
  store i8 %1, ptr %0, align 1
  %2 = load i8, ptr %0, align 1, !range !6, !noundef !4
  %3 = trunc i8 %2 to i1
  ret i1 %3
}

; std::sync::poison::Flag::done
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @_ZN3std4sync6poison4Flag4done17hd53edea5afda5490E(ptr align 1 %self, ptr align 1 %guard) unnamed_addr #2 {
start:
  %_3 = alloca i8, align 1
  %0 = load i8, ptr %guard, align 1, !range !6, !noundef !4
  %_5 = trunc i8 %0 to i1
  %_4 = xor i1 %_5, true
  br i1 %_4, label %bb2, label %bb1

bb1:                                              ; preds = %start
  store i8 0, ptr %_3, align 1
  br label %bb3

bb2:                                              ; preds = %start
; call std::panicking::panic_count::count_is_zero
  %_9 = call zeroext i1 @_ZN3std9panicking11panic_count13count_is_zero17h9646fe124dd6cf7dE()
  %_6 = xor i1 %_9, true
  %1 = zext i1 %_6 to i8
  store i8 %1, ptr %_3, align 1
  br label %bb3

bb3:                                              ; preds = %bb1, %bb2
  %2 = load i8, ptr %_3, align 1, !range !6, !noundef !4
  %3 = trunc i8 %2 to i1
  br i1 %3, label %bb4, label %bb5

bb5:                                              ; preds = %bb4, %bb3
  ret void

bb4:                                              ; preds = %bb3
; call core::sync::atomic::atomic_store
  call void @_ZN4core4sync6atomic12atomic_store17h704cdb2901001363E(ptr %self, i8 1, i8 0)
  br label %bb5
}

; std::sync::poison::Flag::guard
; Function Attrs: inlinehint nonlazybind uwtable
define internal { i8, i8 } @_ZN3std4sync6poison4Flag5guard17hcbe2af90a557f7cfE(ptr align 1 %self) unnamed_addr #2 {
start:
  %ret = alloca i8, align 1
  %0 = alloca { i8, i8 }, align 1
; call std::panicking::panic_count::count_is_zero
  %_5 = call zeroext i1 @_ZN3std9panicking11panic_count13count_is_zero17h9646fe124dd6cf7dE()
  %_3 = xor i1 %_5, true
  %1 = zext i1 %_3 to i8
  store i8 %1, ptr %ret, align 1
; call core::sync::atomic::atomic_load
  %_8 = call i8 @_ZN4core4sync6atomic11atomic_load17ha1ae3fdc8852c067E(ptr %self, i8 0)
  %2 = icmp eq i8 %_8, 0
  br i1 %2, label %bb3, label %bb1

bb3:                                              ; preds = %start
  %3 = load i8, ptr %ret, align 1, !range !6, !noundef !4
  %4 = trunc i8 %3 to i1
  %5 = getelementptr inbounds { i8, i8 }, ptr %0, i32 0, i32 1
  %6 = zext i1 %4 to i8
  store i8 %6, ptr %5, align 1
  store i8 0, ptr %0, align 1
  br label %bb4

bb1:                                              ; preds = %start
  %7 = load i8, ptr %ret, align 1, !range !6, !noundef !4
  %8 = trunc i8 %7 to i1
; call std::sync::poison::PoisonError<T>::new
  %_4 = call zeroext i1 @"_ZN3std4sync6poison20PoisonError$LT$T$GT$3new17h625bbd3cff7c0439E"(i1 zeroext %8)
  %9 = getelementptr inbounds { i8, i8 }, ptr %0, i32 0, i32 1
  %10 = zext i1 %_4 to i8
  store i8 %10, ptr %9, align 1
  store i8 1, ptr %0, align 1
  br label %bb4

bb4:                                              ; preds = %bb3, %bb1
  %11 = getelementptr inbounds { i8, i8 }, ptr %0, i32 0, i32 0
  %12 = load i8, ptr %11, align 1, !range !6, !noundef !4
  %13 = trunc i8 %12 to i1
  %14 = getelementptr inbounds { i8, i8 }, ptr %0, i32 0, i32 1
  %15 = load i8, ptr %14, align 1, !noundef !4
  %16 = zext i1 %13 to i8
  %17 = insertvalue { i8, i8 } poison, i8 %16, 0
  %18 = insertvalue { i8, i8 } %17, i8 %15, 1
  ret { i8, i8 } %18
}

; std::panicking::panic_count::count_is_zero
; Function Attrs: inlinehint nonlazybind uwtable
define internal zeroext i1 @_ZN3std9panicking11panic_count13count_is_zero17h9646fe124dd6cf7dE() unnamed_addr #2 {
start:
  %0 = alloca i8, align 1
; call core::sync::atomic::atomic_load
  %_2 = call i64 @_ZN4core4sync6atomic11atomic_load17h1e5f6e53215df76eE(ptr @_ZN3std9panicking11panic_count18GLOBAL_PANIC_COUNT17hd8bdcf533dbffa86E, i8 0)
  %_1 = and i64 %_2, 9223372036854775807
  %1 = icmp eq i64 %_1, 0
  br i1 %1, label %bb1, label %bb2

bb1:                                              ; preds = %start
  store i8 1, ptr %0, align 1
  br label %bb3

bb2:                                              ; preds = %start
; call std::panicking::panic_count::is_zero_slow_path
  %2 = call zeroext i1 @_ZN3std9panicking11panic_count17is_zero_slow_path17h1811f0c0aba3e0a6E()
  %3 = zext i1 %2 to i8
  store i8 %3, ptr %0, align 1
  br label %bb3

bb3:                                              ; preds = %bb1, %bb2
  %4 = load i8, ptr %0, align 1, !range !6, !noundef !4
  %5 = trunc i8 %4 to i1
  ret i1 %5
}

; core::fmt::ArgumentV1::new_display
; Function Attrs: inlinehint nonlazybind uwtable
define internal { ptr, ptr } @_ZN4core3fmt10ArgumentV111new_display17h94aab3924589f579E(ptr align 4 %x) unnamed_addr #2 {
start:
  %0 = alloca { ptr, ptr }, align 8
  store ptr %x, ptr %0, align 8
  %1 = getelementptr inbounds { ptr, ptr }, ptr %0, i32 0, i32 1
  store ptr @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h2d0a9332273b8593E", ptr %1, align 8
  %2 = getelementptr inbounds { ptr, ptr }, ptr %0, i32 0, i32 0
  %3 = load ptr, ptr %2, align 8, !nonnull !4, !align !8, !noundef !4
  %4 = getelementptr inbounds { ptr, ptr }, ptr %0, i32 0, i32 1
  %5 = load ptr, ptr %4, align 8, !nonnull !4, !noundef !4
  %6 = insertvalue { ptr, ptr } poison, ptr %3, 0
  %7 = insertvalue { ptr, ptr } %6, ptr %5, 1
  ret { ptr, ptr } %7
}

; core::fmt::Arguments::new_v1
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @_ZN4core3fmt9Arguments6new_v117hbeeec5b14b13e1aeE(ptr sret(%"core::fmt::Arguments<'_>") %0, ptr align 8 %pieces.0, i64 %pieces.1, ptr align 8 %args.0, i64 %args.1) unnamed_addr #2 {
start:
  %_14 = alloca { ptr, i64 }, align 8
  %_12 = alloca %"core::fmt::Arguments<'_>", align 8
  %_3 = alloca i8, align 1
  %_4 = icmp ult i64 %pieces.1, %args.1
  br i1 %_4, label %bb1, label %bb2

bb2:                                              ; preds = %start
  %_9 = add i64 %args.1, 1
  %_7 = icmp ugt i64 %pieces.1, %_9
  %1 = zext i1 %_7 to i8
  store i8 %1, ptr %_3, align 1
  br label %bb3

bb1:                                              ; preds = %start
  store i8 1, ptr %_3, align 1
  br label %bb3

bb3:                                              ; preds = %bb2, %bb1
  %2 = load i8, ptr %_3, align 1, !range !6, !noundef !4
  %3 = trunc i8 %2 to i1
  br i1 %3, label %bb4, label %bb6

bb6:                                              ; preds = %bb3
  store ptr null, ptr %_14, align 8
  %4 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %0, i32 0, i32 1
  %5 = getelementptr inbounds { ptr, i64 }, ptr %4, i32 0, i32 0
  store ptr %pieces.0, ptr %5, align 8
  %6 = getelementptr inbounds { ptr, i64 }, ptr %4, i32 0, i32 1
  store i64 %pieces.1, ptr %6, align 8
  %7 = getelementptr inbounds { ptr, i64 }, ptr %_14, i32 0, i32 0
  %8 = load ptr, ptr %7, align 8, !align !9, !noundef !4
  %9 = getelementptr inbounds { ptr, i64 }, ptr %_14, i32 0, i32 1
  %10 = load i64, ptr %9, align 8
  %11 = getelementptr inbounds { ptr, i64 }, ptr %0, i32 0, i32 0
  store ptr %8, ptr %11, align 8
  %12 = getelementptr inbounds { ptr, i64 }, ptr %0, i32 0, i32 1
  store i64 %10, ptr %12, align 8
  %13 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %0, i32 0, i32 2
  %14 = getelementptr inbounds { ptr, i64 }, ptr %13, i32 0, i32 0
  store ptr %args.0, ptr %14, align 8
  %15 = getelementptr inbounds { ptr, i64 }, ptr %13, i32 0, i32 1
  store i64 %args.1, ptr %15, align 8
  ret void

bb4:                                              ; preds = %bb3
; call core::fmt::Arguments::new_const
  call void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %_12, ptr align 8 @alloc_560206a49c61adca6f3f0639a12632eb, i64 1)
; call core::panicking::panic_fmt
  call void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr %_12, ptr align 8 @alloc_ea676e06474b3ad20dc2b78cc1c22fa8) #11
  unreachable
}

; core::fmt::Arguments::new_const
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %0, ptr align 8 %pieces.0, i64 %pieces.1) unnamed_addr #2 {
start:
  %_7 = alloca { ptr, i64 }, align 8
  %_5 = alloca %"core::fmt::Arguments<'_>", align 8
  %_2 = icmp ugt i64 %pieces.1, 1
  br i1 %_2, label %bb1, label %bb3

bb3:                                              ; preds = %start
  store ptr null, ptr %_7, align 8
  %1 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %0, i32 0, i32 1
  %2 = getelementptr inbounds { ptr, i64 }, ptr %1, i32 0, i32 0
  store ptr %pieces.0, ptr %2, align 8
  %3 = getelementptr inbounds { ptr, i64 }, ptr %1, i32 0, i32 1
  store i64 %pieces.1, ptr %3, align 8
  %4 = getelementptr inbounds { ptr, i64 }, ptr %_7, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8, !align !9, !noundef !4
  %6 = getelementptr inbounds { ptr, i64 }, ptr %_7, i32 0, i32 1
  %7 = load i64, ptr %6, align 8
  %8 = getelementptr inbounds { ptr, i64 }, ptr %0, i32 0, i32 0
  store ptr %5, ptr %8, align 8
  %9 = getelementptr inbounds { ptr, i64 }, ptr %0, i32 0, i32 1
  store i64 %7, ptr %9, align 8
  %10 = getelementptr inbounds %"core::fmt::Arguments<'_>", ptr %0, i32 0, i32 2
  %11 = getelementptr inbounds { ptr, i64 }, ptr %10, i32 0, i32 0
  store ptr @alloc_513570631223a12912d85da2bec3b15a, ptr %11, align 8
  %12 = getelementptr inbounds { ptr, i64 }, ptr %10, i32 0, i32 1
  store i64 0, ptr %12, align 8
  ret void

bb1:                                              ; preds = %start
; call core::fmt::Arguments::new_const
  call void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %_5, ptr align 8 @alloc_560206a49c61adca6f3f0639a12632eb, i64 1)
; call core::panicking::panic_fmt
  call void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr %_5, ptr align 8 @alloc_584d991c255ecc0b9a8eb25813e7c09e) #11
  unreachable
}

; core::ops::function::FnOnce::call_once{{vtable.shim}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal i32 @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h65e4c206f9429665E"(ptr %_1) unnamed_addr #2 {
start:
  %_2 = alloca {}, align 1
  %0 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
; call core::ops::function::FnOnce::call_once
  %1 = call i32 @_ZN4core3ops8function6FnOnce9call_once17ha0fff4bcbab44f24E(ptr %0)
  ret i32 %1
}

; core::ops::function::FnOnce::call_once
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @_ZN4core3ops8function6FnOnce9call_once17h81c93097912e68aaE(ptr %_1) unnamed_addr #2 {
start:
  %_2 = alloca {}, align 1
  call void %_1()
  ret void
}

; core::ops::function::FnOnce::call_once
; Function Attrs: inlinehint nonlazybind uwtable
define internal i32 @_ZN4core3ops8function6FnOnce9call_once17ha0fff4bcbab44f24E(ptr %0) unnamed_addr #2 personality ptr @rust_eh_personality {
start:
  %1 = alloca { ptr, i32 }, align 8
  %_2 = alloca {}, align 1
  %_1 = alloca ptr, align 8
  store ptr %0, ptr %_1, align 8
; invoke std::rt::lang_start::{{closure}}
  %2 = invoke i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h5b1b8bd09094ae34E"(ptr align 8 %_1)
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

; core::ptr::drop_in_place<std::sync::mutex::MutexGuard<i32>>
; Function Attrs: nonlazybind uwtable
define internal void @"_ZN4core3ptr60drop_in_place$LT$std..sync..mutex..MutexGuard$LT$i32$GT$$GT$17hd61a238c527ba340E"(ptr %_1) unnamed_addr #1 {
start:
; call <std::sync::mutex::MutexGuard<T> as core::ops::drop::Drop>::drop
  call void @"_ZN79_$LT$std..sync..mutex..MutexGuard$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7838aef8acf185f0E"(ptr align 8 %_1)
  ret void
}

; core::ptr::drop_in_place<std::rt::lang_start<()>::{{closure}}>
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @"_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hd8cbafddca2b9641E"(ptr %_1) unnamed_addr #2 {
start:
  ret void
}

; core::ptr::drop_in_place<std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<i32>>>
; Function Attrs: nonlazybind uwtable
define internal void @"_ZN4core3ptr98drop_in_place$LT$std..sync..poison..PoisonError$LT$std..sync..mutex..MutexGuard$LT$i32$GT$$GT$$GT$17hdeec11bbf1c42d0fE"(ptr %_1) unnamed_addr #1 {
start:
; call core::ptr::drop_in_place<std::sync::mutex::MutexGuard<i32>>
  call void @"_ZN4core3ptr60drop_in_place$LT$std..sync..mutex..MutexGuard$LT$i32$GT$$GT$17hd61a238c527ba340E"(ptr %_1)
  ret void
}

; core::sync::atomic::atomic_load
; Function Attrs: inlinehint nonlazybind uwtable
define internal i64 @_ZN4core4sync6atomic11atomic_load17h1e5f6e53215df76eE(ptr %dst, i8 %0) unnamed_addr #2 {
start:
  %_8 = alloca %"core::fmt::Arguments<'_>", align 8
  %_5 = alloca %"core::fmt::Arguments<'_>", align 8
  %1 = alloca i64, align 8
  %order = alloca i8, align 1
  store i8 %0, ptr %order, align 1
  %2 = load i8, ptr %order, align 1, !range !10, !noundef !4
  %_3 = zext i8 %2 to i64
  switch i64 %_3, label %bb2 [
    i64 0, label %bb3
    i64 1, label %bb6
    i64 2, label %bb4
    i64 3, label %bb1
    i64 4, label %bb5
  ]

bb2:                                              ; preds = %start
  unreachable

bb3:                                              ; preds = %start
  %3 = load atomic i64, ptr %dst monotonic, align 8
  store i64 %3, ptr %1, align 8
  br label %bb9

bb6:                                              ; preds = %start
; call core::fmt::Arguments::new_const
  call void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %_5, ptr align 8 @alloc_c986ce739acfc2550367c92bb47d7476, i64 1)
; call core::panicking::panic_fmt
  call void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr %_5, ptr align 8 @alloc_86d4430040752d585b931e9d5bb1491d) #11
  unreachable

bb4:                                              ; preds = %start
  %4 = load atomic i64, ptr %dst acquire, align 8
  store i64 %4, ptr %1, align 8
  br label %bb9

bb1:                                              ; preds = %start
; call core::fmt::Arguments::new_const
  call void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %_8, ptr align 8 @alloc_e1829842c862d95248bdb87a26e1372f, i64 1)
; call core::panicking::panic_fmt
  call void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr %_8, ptr align 8 @alloc_dd9d57512755e6660f09fe57446bf051) #11
  unreachable

bb5:                                              ; preds = %start
  %5 = load atomic i64, ptr %dst seq_cst, align 8
  store i64 %5, ptr %1, align 8
  br label %bb9

bb9:                                              ; preds = %bb3, %bb4, %bb5
  %6 = load i64, ptr %1, align 8, !noundef !4
  ret i64 %6
}

; core::sync::atomic::atomic_load
; Function Attrs: inlinehint nonlazybind uwtable
define internal i8 @_ZN4core4sync6atomic11atomic_load17ha1ae3fdc8852c067E(ptr %dst, i8 %0) unnamed_addr #2 {
start:
  %_8 = alloca %"core::fmt::Arguments<'_>", align 8
  %_5 = alloca %"core::fmt::Arguments<'_>", align 8
  %1 = alloca i8, align 1
  %order = alloca i8, align 1
  store i8 %0, ptr %order, align 1
  %2 = load i8, ptr %order, align 1, !range !10, !noundef !4
  %_3 = zext i8 %2 to i64
  switch i64 %_3, label %bb2 [
    i64 0, label %bb3
    i64 1, label %bb6
    i64 2, label %bb4
    i64 3, label %bb1
    i64 4, label %bb5
  ]

bb2:                                              ; preds = %start
  unreachable

bb3:                                              ; preds = %start
  %3 = load atomic i8, ptr %dst monotonic, align 1
  store i8 %3, ptr %1, align 1
  br label %bb9

bb6:                                              ; preds = %start
; call core::fmt::Arguments::new_const
  call void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %_5, ptr align 8 @alloc_c986ce739acfc2550367c92bb47d7476, i64 1)
; call core::panicking::panic_fmt
  call void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr %_5, ptr align 8 @alloc_86d4430040752d585b931e9d5bb1491d) #11
  unreachable

bb4:                                              ; preds = %start
  %4 = load atomic i8, ptr %dst acquire, align 1
  store i8 %4, ptr %1, align 1
  br label %bb9

bb1:                                              ; preds = %start
; call core::fmt::Arguments::new_const
  call void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %_8, ptr align 8 @alloc_e1829842c862d95248bdb87a26e1372f, i64 1)
; call core::panicking::panic_fmt
  call void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr %_8, ptr align 8 @alloc_dd9d57512755e6660f09fe57446bf051) #11
  unreachable

bb5:                                              ; preds = %start
  %5 = load atomic i8, ptr %dst seq_cst, align 1
  store i8 %5, ptr %1, align 1
  br label %bb9

bb9:                                              ; preds = %bb3, %bb4, %bb5
  %6 = load i8, ptr %1, align 1, !noundef !4
  ret i8 %6
}

; core::sync::atomic::atomic_store
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @_ZN4core4sync6atomic12atomic_store17h704cdb2901001363E(ptr %dst, i8 %val, i8 %0) unnamed_addr #2 {
start:
  %_9 = alloca %"core::fmt::Arguments<'_>", align 8
  %_6 = alloca %"core::fmt::Arguments<'_>", align 8
  %order = alloca i8, align 1
  store i8 %0, ptr %order, align 1
  %1 = load i8, ptr %order, align 1, !range !10, !noundef !4
  %_4 = zext i8 %1 to i64
  switch i64 %_4, label %bb2 [
    i64 0, label %bb3
    i64 1, label %bb4
    i64 2, label %bb6
    i64 3, label %bb1
    i64 4, label %bb5
  ]

bb2:                                              ; preds = %start
  unreachable

bb3:                                              ; preds = %start
  store atomic i8 %val, ptr %dst monotonic, align 1
  br label %bb9

bb4:                                              ; preds = %start
  store atomic i8 %val, ptr %dst release, align 1
  br label %bb9

bb6:                                              ; preds = %start
; call core::fmt::Arguments::new_const
  call void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %_6, ptr align 8 @alloc_a5cc7fc528e53ce267236c14ebed42c5, i64 1)
; call core::panicking::panic_fmt
  call void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr %_6, ptr align 8 @alloc_14a783c8722e23b13f162efb02239a83) #11
  unreachable

bb1:                                              ; preds = %start
; call core::fmt::Arguments::new_const
  call void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %_9, ptr align 8 @alloc_e8a173a411485b7e37220624c537a890, i64 1)
; call core::panicking::panic_fmt
  call void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr %_9, ptr align 8 @alloc_3eee851da11e7f3ecded4ef69bb02c20) #11
  unreachable

bb5:                                              ; preds = %start
  store atomic i8 %val, ptr %dst seq_cst, align 1
  br label %bb9

bb9:                                              ; preds = %bb3, %bb4, %bb5
  ret void
}

; core::sync::atomic::atomic_compare_exchange
; Function Attrs: inlinehint nonlazybind uwtable
define internal { i32, i32 } @_ZN4core4sync6atomic23atomic_compare_exchange17h8404968de7b5a457E(ptr %dst, i32 %old, i32 %new, i8 %success, i8 %failure) unnamed_addr #2 {
start:
  %_21 = alloca %"core::fmt::Arguments<'_>", align 8
  %_18 = alloca %"core::fmt::Arguments<'_>", align 8
  %_9 = alloca { i8, i8 }, align 1
  %_8 = alloca { i32, i8 }, align 4
  %0 = alloca { i32, i32 }, align 4
  store i8 %success, ptr %_9, align 1
  %1 = getelementptr inbounds { i8, i8 }, ptr %_9, i32 0, i32 1
  store i8 %failure, ptr %1, align 1
  %2 = load i8, ptr %_9, align 1, !range !10, !noundef !4
  %_16 = zext i8 %2 to i64
  switch i64 %_16, label %bb7 [
    i64 0, label %bb1
    i64 1, label %bb3
    i64 2, label %bb4
    i64 3, label %bb5
    i64 4, label %bb6
  ]

bb7:                                              ; preds = %start
  unreachable

bb1:                                              ; preds = %start
  %3 = getelementptr inbounds { i8, i8 }, ptr %_9, i32 0, i32 1
  %4 = load i8, ptr %3, align 1, !range !10, !noundef !4
  %_10 = zext i8 %4 to i64
  switch i64 %_10, label %bb2 [
    i64 0, label %bb9
    i64 2, label %bb10
    i64 4, label %bb11
  ]

bb3:                                              ; preds = %start
  %5 = getelementptr inbounds { i8, i8 }, ptr %_9, i32 0, i32 1
  %6 = load i8, ptr %5, align 1, !range !10, !noundef !4
  %_11 = zext i8 %6 to i64
  switch i64 %_11, label %bb2 [
    i64 0, label %bb15
    i64 2, label %bb16
    i64 4, label %bb17
  ]

bb4:                                              ; preds = %start
  %7 = getelementptr inbounds { i8, i8 }, ptr %_9, i32 0, i32 1
  %8 = load i8, ptr %7, align 1, !range !10, !noundef !4
  %_12 = zext i8 %8 to i64
  switch i64 %_12, label %bb2 [
    i64 0, label %bb12
    i64 2, label %bb13
    i64 4, label %bb14
  ]

bb5:                                              ; preds = %start
  %9 = getelementptr inbounds { i8, i8 }, ptr %_9, i32 0, i32 1
  %10 = load i8, ptr %9, align 1, !range !10, !noundef !4
  %_13 = zext i8 %10 to i64
  switch i64 %_13, label %bb2 [
    i64 0, label %bb18
    i64 2, label %bb19
    i64 4, label %bb20
  ]

bb6:                                              ; preds = %start
  %11 = getelementptr inbounds { i8, i8 }, ptr %_9, i32 0, i32 1
  %12 = load i8, ptr %11, align 1, !range !10, !noundef !4
  %_14 = zext i8 %12 to i64
  switch i64 %_14, label %bb2 [
    i64 0, label %bb21
    i64 2, label %bb22
    i64 4, label %bb23
  ]

bb2:                                              ; preds = %bb1, %bb3, %bb4, %bb5, %bb6
  %13 = getelementptr inbounds { i8, i8 }, ptr %_9, i32 0, i32 1
  %14 = load i8, ptr %13, align 1, !range !10, !noundef !4
  %_15 = zext i8 %14 to i64
  %15 = icmp eq i64 %_15, 1
  br i1 %15, label %bb8, label %bb24

bb21:                                             ; preds = %bb6
  %16 = cmpxchg ptr %dst, i32 %old, i32 %new seq_cst monotonic, align 4
  %17 = extractvalue { i32, i1 } %16, 0
  %18 = extractvalue { i32, i1 } %16, 1
  %19 = zext i1 %18 to i8
  store i32 %17, ptr %_8, align 4
  %20 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %19, ptr %20, align 4
  br label %bb27

bb22:                                             ; preds = %bb6
  %21 = cmpxchg ptr %dst, i32 %old, i32 %new seq_cst acquire, align 4
  %22 = extractvalue { i32, i1 } %21, 0
  %23 = extractvalue { i32, i1 } %21, 1
  %24 = zext i1 %23 to i8
  store i32 %22, ptr %_8, align 4
  %25 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %24, ptr %25, align 4
  br label %bb27

bb23:                                             ; preds = %bb6
  %26 = cmpxchg ptr %dst, i32 %old, i32 %new seq_cst seq_cst, align 4
  %27 = extractvalue { i32, i1 } %26, 0
  %28 = extractvalue { i32, i1 } %26, 1
  %29 = zext i1 %28 to i8
  store i32 %27, ptr %_8, align 4
  %30 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %29, ptr %30, align 4
  br label %bb27

bb27:                                             ; preds = %bb9, %bb10, %bb11, %bb15, %bb16, %bb17, %bb12, %bb13, %bb14, %bb18, %bb19, %bb20, %bb21, %bb22, %bb23
  %val = load i32, ptr %_8, align 4, !noundef !4
  %31 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  %32 = load i8, ptr %31, align 4, !range !6, !noundef !4
  %ok = trunc i8 %32 to i1
  br i1 %ok, label %bb28, label %bb29

bb18:                                             ; preds = %bb5
  %33 = cmpxchg ptr %dst, i32 %old, i32 %new acq_rel monotonic, align 4
  %34 = extractvalue { i32, i1 } %33, 0
  %35 = extractvalue { i32, i1 } %33, 1
  %36 = zext i1 %35 to i8
  store i32 %34, ptr %_8, align 4
  %37 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %36, ptr %37, align 4
  br label %bb27

bb19:                                             ; preds = %bb5
  %38 = cmpxchg ptr %dst, i32 %old, i32 %new acq_rel acquire, align 4
  %39 = extractvalue { i32, i1 } %38, 0
  %40 = extractvalue { i32, i1 } %38, 1
  %41 = zext i1 %40 to i8
  store i32 %39, ptr %_8, align 4
  %42 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %41, ptr %42, align 4
  br label %bb27

bb20:                                             ; preds = %bb5
  %43 = cmpxchg ptr %dst, i32 %old, i32 %new acq_rel seq_cst, align 4
  %44 = extractvalue { i32, i1 } %43, 0
  %45 = extractvalue { i32, i1 } %43, 1
  %46 = zext i1 %45 to i8
  store i32 %44, ptr %_8, align 4
  %47 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %46, ptr %47, align 4
  br label %bb27

bb12:                                             ; preds = %bb4
  %48 = cmpxchg ptr %dst, i32 %old, i32 %new acquire monotonic, align 4
  %49 = extractvalue { i32, i1 } %48, 0
  %50 = extractvalue { i32, i1 } %48, 1
  %51 = zext i1 %50 to i8
  store i32 %49, ptr %_8, align 4
  %52 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %51, ptr %52, align 4
  br label %bb27

bb13:                                             ; preds = %bb4
  %53 = cmpxchg ptr %dst, i32 %old, i32 %new acquire acquire, align 4
  %54 = extractvalue { i32, i1 } %53, 0
  %55 = extractvalue { i32, i1 } %53, 1
  %56 = zext i1 %55 to i8
  store i32 %54, ptr %_8, align 4
  %57 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %56, ptr %57, align 4
  br label %bb27

bb14:                                             ; preds = %bb4
  %58 = cmpxchg ptr %dst, i32 %old, i32 %new acquire seq_cst, align 4
  %59 = extractvalue { i32, i1 } %58, 0
  %60 = extractvalue { i32, i1 } %58, 1
  %61 = zext i1 %60 to i8
  store i32 %59, ptr %_8, align 4
  %62 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %61, ptr %62, align 4
  br label %bb27

bb15:                                             ; preds = %bb3
  %63 = cmpxchg ptr %dst, i32 %old, i32 %new release monotonic, align 4
  %64 = extractvalue { i32, i1 } %63, 0
  %65 = extractvalue { i32, i1 } %63, 1
  %66 = zext i1 %65 to i8
  store i32 %64, ptr %_8, align 4
  %67 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %66, ptr %67, align 4
  br label %bb27

bb16:                                             ; preds = %bb3
  %68 = cmpxchg ptr %dst, i32 %old, i32 %new release acquire, align 4
  %69 = extractvalue { i32, i1 } %68, 0
  %70 = extractvalue { i32, i1 } %68, 1
  %71 = zext i1 %70 to i8
  store i32 %69, ptr %_8, align 4
  %72 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %71, ptr %72, align 4
  br label %bb27

bb17:                                             ; preds = %bb3
  %73 = cmpxchg ptr %dst, i32 %old, i32 %new release seq_cst, align 4
  %74 = extractvalue { i32, i1 } %73, 0
  %75 = extractvalue { i32, i1 } %73, 1
  %76 = zext i1 %75 to i8
  store i32 %74, ptr %_8, align 4
  %77 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %76, ptr %77, align 4
  br label %bb27

bb9:                                              ; preds = %bb1
  %78 = cmpxchg ptr %dst, i32 %old, i32 %new monotonic monotonic, align 4
  %79 = extractvalue { i32, i1 } %78, 0
  %80 = extractvalue { i32, i1 } %78, 1
  %81 = zext i1 %80 to i8
  store i32 %79, ptr %_8, align 4
  %82 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %81, ptr %82, align 4
  br label %bb27

bb10:                                             ; preds = %bb1
  %83 = cmpxchg ptr %dst, i32 %old, i32 %new monotonic acquire, align 4
  %84 = extractvalue { i32, i1 } %83, 0
  %85 = extractvalue { i32, i1 } %83, 1
  %86 = zext i1 %85 to i8
  store i32 %84, ptr %_8, align 4
  %87 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %86, ptr %87, align 4
  br label %bb27

bb11:                                             ; preds = %bb1
  %88 = cmpxchg ptr %dst, i32 %old, i32 %new monotonic seq_cst, align 4
  %89 = extractvalue { i32, i1 } %88, 0
  %90 = extractvalue { i32, i1 } %88, 1
  %91 = zext i1 %90 to i8
  store i32 %89, ptr %_8, align 4
  %92 = getelementptr inbounds { i32, i8 }, ptr %_8, i32 0, i32 1
  store i8 %91, ptr %92, align 4
  br label %bb27

bb8:                                              ; preds = %bb2
; call core::fmt::Arguments::new_const
  call void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %_21, ptr align 8 @alloc_406c3ccfb949c60617508c1453ca62ba, i64 1)
; call core::panicking::panic_fmt
  call void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr %_21, ptr align 8 @alloc_5b75a3d48c4b4b0a1bfc1734af871388) #11
  unreachable

bb24:                                             ; preds = %bb2
; call core::fmt::Arguments::new_const
  call void @_ZN4core3fmt9Arguments9new_const17hed2bf08ac63863dbE(ptr sret(%"core::fmt::Arguments<'_>") %_18, ptr align 8 @alloc_53963eedc63e9e4352c653ec571ba638, i64 1)
; call core::panicking::panic_fmt
  call void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr %_18, ptr align 8 @alloc_2feb807b751aebf34c93b8589ebd6a4c) #11
  unreachable

bb29:                                             ; preds = %bb27
  %93 = getelementptr inbounds { i32, i32 }, ptr %0, i32 0, i32 1
  store i32 %val, ptr %93, align 4
  store i32 1, ptr %0, align 4
  br label %bb30

bb28:                                             ; preds = %bb27
  %94 = getelementptr inbounds { i32, i32 }, ptr %0, i32 0, i32 1
  store i32 %val, ptr %94, align 4
  store i32 0, ptr %0, align 4
  br label %bb30

bb30:                                             ; preds = %bb29, %bb28
  %95 = getelementptr inbounds { i32, i32 }, ptr %0, i32 0, i32 0
  %96 = load i32, ptr %95, align 4, !range !5, !noundef !4
  %97 = getelementptr inbounds { i32, i32 }, ptr %0, i32 0, i32 1
  %98 = load i32, ptr %97, align 4, !noundef !4
  %99 = insertvalue { i32, i32 } poison, i32 %96, 0
  %100 = insertvalue { i32, i32 } %99, i32 %98, 1
  ret { i32, i32 } %100
}

; core::result::Result<T,E>::unwrap
; Function Attrs: inlinehint nonlazybind uwtable
define internal { ptr, i8 } @"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h550db7cf52e138beE"(ptr %self, ptr align 8 %0) unnamed_addr #2 personality ptr @rust_eh_personality {
start:
  %1 = alloca { ptr, i32 }, align 8
  %e = alloca { ptr, i8 }, align 8
  %_2 = load i64, ptr %self, align 8, !range !11, !noundef !4
  %2 = icmp eq i64 %_2, 0
  br i1 %2, label %bb3, label %bb1

bb3:                                              ; preds = %start
  %3 = getelementptr inbounds %"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>::Ok", ptr %self, i32 0, i32 1
  %4 = getelementptr inbounds { ptr, i8 }, ptr %3, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8, !nonnull !4, !align !7, !noundef !4
  %6 = getelementptr inbounds { ptr, i8 }, ptr %3, i32 0, i32 1
  %7 = load i8, ptr %6, align 8, !range !6, !noundef !4
  %8 = trunc i8 %7 to i1
  %9 = zext i1 %8 to i8
  %10 = insertvalue { ptr, i8 } poison, ptr %5, 0
  %11 = insertvalue { ptr, i8 } %10, i8 %9, 1
  ret { ptr, i8 } %11

bb1:                                              ; preds = %start
  %12 = getelementptr inbounds %"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>::Err", ptr %self, i32 0, i32 1
  %13 = getelementptr inbounds { ptr, i8 }, ptr %12, i32 0, i32 0
  %14 = load ptr, ptr %13, align 8, !nonnull !4, !align !7, !noundef !4
  %15 = getelementptr inbounds { ptr, i8 }, ptr %12, i32 0, i32 1
  %16 = load i8, ptr %15, align 8, !range !6, !noundef !4
  %17 = trunc i8 %16 to i1
  %18 = getelementptr inbounds { ptr, i8 }, ptr %e, i32 0, i32 0
  store ptr %14, ptr %18, align 8
  %19 = getelementptr inbounds { ptr, i8 }, ptr %e, i32 0, i32 1
  %20 = zext i1 %17 to i8
  store i8 %20, ptr %19, align 8
; invoke core::result::unwrap_failed
  invoke void @_ZN4core6result13unwrap_failed17h97f3d6d985e2e024E(ptr align 1 @alloc_00ae4b301f7fab8ac9617c03fcbd7274, i64 43, ptr align 1 %e, ptr align 8 @vtable.1, ptr align 8 %0) #11
          to label %unreachable unwind label %cleanup

bb2:                                              ; No predecessors!
  unreachable

bb4:                                              ; preds = %cleanup
; invoke core::ptr::drop_in_place<std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<i32>>>
  invoke void @"_ZN4core3ptr98drop_in_place$LT$std..sync..poison..PoisonError$LT$std..sync..mutex..MutexGuard$LT$i32$GT$$GT$$GT$17hdeec11bbf1c42d0fE"(ptr %e) #12
          to label %bb5 unwind label %terminate

cleanup:                                          ; preds = %bb1
  %21 = landingpad { ptr, i32 }
          cleanup
  %22 = extractvalue { ptr, i32 } %21, 0
  %23 = extractvalue { ptr, i32 } %21, 1
  %24 = getelementptr inbounds { ptr, i32 }, ptr %1, i32 0, i32 0
  store ptr %22, ptr %24, align 8
  %25 = getelementptr inbounds { ptr, i32 }, ptr %1, i32 0, i32 1
  store i32 %23, ptr %25, align 8
  br label %bb4

unreachable:                                      ; preds = %bb1
  unreachable

terminate:                                        ; preds = %bb4
  %26 = landingpad { ptr, i32 }
          cleanup
  %27 = extractvalue { ptr, i32 } %26, 0
  %28 = extractvalue { ptr, i32 } %26, 1
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h0f19cb8e77aed642E() #13
  unreachable

bb5:                                              ; preds = %bb4
  %29 = load ptr, ptr %1, align 8, !noundef !4
  %30 = getelementptr inbounds { ptr, i32 }, ptr %1, i32 0, i32 1
  %31 = load i32, ptr %30, align 8, !noundef !4
  %32 = insertvalue { ptr, i32 } poison, ptr %29, 0
  %33 = insertvalue { ptr, i32 } %32, i32 %31, 1
  resume { ptr, i32 } %33
}

; <() as std::process::Termination>::report
; Function Attrs: inlinehint nonlazybind uwtable
define internal i8 @"_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h6370ea2f9d98ae59E"() unnamed_addr #2 {
start:
  ret i8 0
}

; <std::sync::poison::PoisonError<T> as core::fmt::Debug>::fmt
; Function Attrs: nonlazybind uwtable
define internal zeroext i1 @"_ZN76_$LT$std..sync..poison..PoisonError$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h3d3b2be080f6ef92E"(ptr align 8 %self, ptr align 8 %f) unnamed_addr #1 {
start:
  %_4 = alloca %"core::fmt::builders::DebugStruct<'_, '_>", align 8
; call core::fmt::Formatter::debug_struct
  call void @_ZN4core3fmt9Formatter12debug_struct17hbeabf85a045ca3ccE(ptr sret(%"core::fmt::builders::DebugStruct<'_, '_>") %_4, ptr align 8 %f, ptr align 1 @alloc_8e2410b80645266732854088d21653bc, i64 11)
; call core::fmt::builders::DebugStruct::finish_non_exhaustive
  %0 = call zeroext i1 @_ZN4core3fmt8builders11DebugStruct21finish_non_exhaustive17h36033f4c55f69fc1E(ptr align 8 %_4)
  ret i1 %0
}

; <std::sync::mutex::MutexGuard<T> as core::ops::drop::Drop>::drop
; Function Attrs: inlinehint nonlazybind uwtable
define internal void @"_ZN79_$LT$std..sync..mutex..MutexGuard$LT$T$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h7838aef8acf185f0E"(ptr align 8 %self) unnamed_addr #2 {
start:
  %0 = alloca i32, align 4
  %_6 = load ptr, ptr %self, align 8, !nonnull !4, !align !7, !noundef !4
  %_3 = getelementptr inbounds %"std::sync::mutex::Mutex<i32>", ptr %_6, i32 0, i32 1
  %_4 = getelementptr inbounds { ptr, i8 }, ptr %self, i32 0, i32 1
; call std::sync::poison::Flag::done
  call void @_ZN3std4sync6poison4Flag4done17hd53edea5afda5490E(ptr align 1 %_3, ptr align 1 %_4)
  %_7 = load ptr, ptr %self, align 8, !nonnull !4, !align !7, !noundef !4
  %1 = atomicrmw xchg ptr %_7, i32 0 release, align 4
  store i32 %1, ptr %0, align 4
  %_8 = load i32, ptr %0, align 4, !noundef !4
  %2 = icmp eq i32 %_8, 2
  br i1 %2, label %bb3, label %bb4

bb3:                                              ; preds = %start
; call std::sys::unix::locks::futex_mutex::Mutex::wake
  call void @_ZN3std3sys4unix5locks11futex_mutex5Mutex4wake17h282fa8427e64b89aE(ptr align 4 %_7)
  br label %bb2

bb4:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb3, %bb4
  ret void
}

; <std::sync::mutex::MutexGuard<T> as core::ops::deref::Deref>::deref
; Function Attrs: nonlazybind uwtable
define internal align 4 ptr @"_ZN81_$LT$std..sync..mutex..MutexGuard$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h227d4445021e35b1E"(ptr align 8 %self) unnamed_addr #1 {
start:
  %_4 = load ptr, ptr %self, align 8, !nonnull !4, !align !7, !noundef !4
  %self1 = getelementptr inbounds %"std::sync::mutex::Mutex<i32>", ptr %_4, i32 0, i32 3
  ret ptr %self1
}

; <std::sync::mutex::MutexGuard<T> as core::ops::deref::DerefMut>::deref_mut
; Function Attrs: nonlazybind uwtable
define internal align 4 ptr @"_ZN84_$LT$std..sync..mutex..MutexGuard$LT$T$GT$$u20$as$u20$core..ops..deref..DerefMut$GT$9deref_mut17hac5ba411f92d75e4E"(ptr align 8 %self) unnamed_addr #1 {
start:
  %_4 = load ptr, ptr %self, align 8, !nonnull !4, !align !7, !noundef !4
  %self1 = getelementptr inbounds %"std::sync::mutex::Mutex<i32>", ptr %_4, i32 0, i32 3
  ret ptr %self1
}

; locks_no_deadlock::main
; Function Attrs: nonlazybind uwtable
define internal void @_ZN17locks_no_deadlock4main17h9920d0e889717c87E() unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %0 = alloca { ptr, i32 }, align 8
  %_30 = alloca [1 x { ptr, ptr }], align 8
  %_26 = alloca %"core::fmt::Arguments<'_>", align 8
  %_20 = alloca %"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>", align 8
  %no_deadlock = alloca { ptr, i8 }, align 8
  %_14 = alloca [1 x { ptr, ptr }], align 8
  %_10 = alloca %"core::fmt::Arguments<'_>", align 8
  %_4 = alloca %"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>", align 8
  %guard = alloca { ptr, i8 }, align 8
  %safe_x = alloca %"std::sync::mutex::Mutex<i32>", align 4
; call std::sync::mutex::Mutex<T>::new
  call void @"_ZN3std4sync5mutex14Mutex$LT$T$GT$3new17h6c6ef35e6eaf06b7E"(ptr sret(%"std::sync::mutex::Mutex<i32>") %safe_x, i32 64)
; call std::sync::mutex::Mutex<T>::lock
  call void @"_ZN3std4sync5mutex14Mutex$LT$T$GT$4lock17h658da0fccc909ca3E"(ptr sret(%"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>") %_4, ptr align 4 %safe_x)
; call core::result::Result<T,E>::unwrap
  %1 = call { ptr, i8 } @"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h550db7cf52e138beE"(ptr %_4, ptr align 8 @alloc_45e6fd4830bcb5aa3cc478bb3b66db88)
  store { ptr, i8 } %1, ptr %guard, align 8
; invoke <std::sync::mutex::MutexGuard<T> as core::ops::deref::DerefMut>::deref_mut
  %_6 = invoke align 4 ptr @"_ZN84_$LT$std..sync..mutex..MutexGuard$LT$T$GT$$u20$as$u20$core..ops..deref..DerefMut$GT$9deref_mut17hac5ba411f92d75e4E"(ptr align 8 %guard)
          to label %bb4 unwind label %cleanup

bb21:                                             ; preds = %cleanup
; invoke core::ptr::drop_in_place<std::sync::mutex::MutexGuard<i32>>
  invoke void @"_ZN4core3ptr60drop_in_place$LT$std..sync..mutex..MutexGuard$LT$i32$GT$$GT$17hd61a238c527ba340E"(ptr %guard) #12
          to label %bb22 unwind label %terminate

cleanup:                                          ; preds = %bb8, %bb7, %bb6, %bb5, %panic, %start
  %2 = landingpad { ptr, i32 }
          cleanup
  %3 = extractvalue { ptr, i32 } %2, 0
  %4 = extractvalue { ptr, i32 } %2, 1
  %5 = getelementptr inbounds { ptr, i32 }, ptr %0, i32 0, i32 0
  store ptr %3, ptr %5, align 8
  %6 = getelementptr inbounds { ptr, i32 }, ptr %0, i32 0, i32 1
  store i32 %4, ptr %6, align 8
  br label %bb21

bb4:                                              ; preds = %start
  %7 = load i32, ptr %_6, align 4, !noundef !4
  %8 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %7, i32 1)
  %_8.0 = extractvalue { i32, i1 } %8, 0
  %_8.1 = extractvalue { i32, i1 } %8, 1
  %9 = call i1 @llvm.expect.i1(i1 %_8.1, i1 false)
  br i1 %9, label %panic, label %bb5

bb5:                                              ; preds = %bb4
  store i32 %_8.0, ptr %_6, align 4
; invoke <std::sync::mutex::MutexGuard<T> as core::ops::deref::Deref>::deref
  %_17 = invoke align 4 ptr @"_ZN81_$LT$std..sync..mutex..MutexGuard$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h227d4445021e35b1E"(ptr align 8 %guard)
          to label %bb6 unwind label %cleanup

panic:                                            ; preds = %bb4
; invoke core::panicking::panic
  invoke void @_ZN4core9panicking5panic17h39466a6143e26d57E(ptr align 1 @str.2, i64 28, ptr align 8 @alloc_c52fd7a625898b5aee71f907f580e7b5) #11
          to label %unreachable unwind label %cleanup

unreachable:                                      ; preds = %panic2, %panic
  unreachable

bb6:                                              ; preds = %bb5
; invoke core::fmt::ArgumentV1::new_display
  %10 = invoke { ptr, ptr } @_ZN4core3fmt10ArgumentV111new_display17h94aab3924589f579E(ptr align 4 %_17)
          to label %bb7 unwind label %cleanup

bb7:                                              ; preds = %bb6
  %_15.0 = extractvalue { ptr, ptr } %10, 0
  %_15.1 = extractvalue { ptr, ptr } %10, 1
  %11 = getelementptr inbounds [1 x { ptr, ptr }], ptr %_14, i64 0, i64 0
  %12 = getelementptr inbounds { ptr, ptr }, ptr %11, i32 0, i32 0
  store ptr %_15.0, ptr %12, align 8
  %13 = getelementptr inbounds { ptr, ptr }, ptr %11, i32 0, i32 1
  store ptr %_15.1, ptr %13, align 8
; invoke core::fmt::Arguments::new_v1
  invoke void @_ZN4core3fmt9Arguments6new_v117hbeeec5b14b13e1aeE(ptr sret(%"core::fmt::Arguments<'_>") %_10, ptr align 8 @alloc_57f302b174bab2721e64f70b64e905fe, i64 2, ptr align 8 %_14, i64 1)
          to label %bb8 unwind label %cleanup

bb8:                                              ; preds = %bb7
; invoke std::io::stdio::_print
  invoke void @_ZN3std2io5stdio6_print17he1fd6c9db1efbff1E(ptr %_10)
          to label %bb9 unwind label %cleanup

bb9:                                              ; preds = %bb8
; call core::ptr::drop_in_place<std::sync::mutex::MutexGuard<i32>>
  call void @"_ZN4core3ptr60drop_in_place$LT$std..sync..mutex..MutexGuard$LT$i32$GT$$GT$17hd61a238c527ba340E"(ptr %guard)
; call std::sync::mutex::Mutex<T>::lock
  call void @"_ZN3std4sync5mutex14Mutex$LT$T$GT$4lock17h658da0fccc909ca3E"(ptr sret(%"core::result::Result<std::sync::mutex::MutexGuard<'_, i32>, std::sync::poison::PoisonError<std::sync::mutex::MutexGuard<'_, i32>>>") %_20, ptr align 4 %safe_x)
; call core::result::Result<T,E>::unwrap
  %14 = call { ptr, i8 } @"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h550db7cf52e138beE"(ptr %_20, ptr align 8 @alloc_06f8f80e64cdaf436bd4cc94d17b0da4)
  store { ptr, i8 } %14, ptr %no_deadlock, align 8
; invoke <std::sync::mutex::MutexGuard<T> as core::ops::deref::DerefMut>::deref_mut
  %_22 = invoke align 4 ptr @"_ZN84_$LT$std..sync..mutex..MutexGuard$LT$T$GT$$u20$as$u20$core..ops..deref..DerefMut$GT$9deref_mut17hac5ba411f92d75e4E"(ptr align 8 %no_deadlock)
          to label %bb13 unwind label %cleanup1

terminate:                                        ; preds = %bb20, %bb21
  %15 = landingpad { ptr, i32 }
          cleanup
  %16 = extractvalue { ptr, i32 } %15, 0
  %17 = extractvalue { ptr, i32 } %15, 1
; call core::panicking::panic_cannot_unwind
  call void @_ZN4core9panicking19panic_cannot_unwind17h0f19cb8e77aed642E() #13
  unreachable

bb22:                                             ; preds = %bb20, %bb21
  %18 = load ptr, ptr %0, align 8, !noundef !4
  %19 = getelementptr inbounds { ptr, i32 }, ptr %0, i32 0, i32 1
  %20 = load i32, ptr %19, align 8, !noundef !4
  %21 = insertvalue { ptr, i32 } poison, ptr %18, 0
  %22 = insertvalue { ptr, i32 } %21, i32 %20, 1
  resume { ptr, i32 } %22

bb20:                                             ; preds = %cleanup1
; invoke core::ptr::drop_in_place<std::sync::mutex::MutexGuard<i32>>
  invoke void @"_ZN4core3ptr60drop_in_place$LT$std..sync..mutex..MutexGuard$LT$i32$GT$$GT$17hd61a238c527ba340E"(ptr %no_deadlock) #12
          to label %bb22 unwind label %terminate

cleanup1:                                         ; preds = %bb17, %bb16, %bb15, %bb14, %panic2, %bb9
  %23 = landingpad { ptr, i32 }
          cleanup
  %24 = extractvalue { ptr, i32 } %23, 0
  %25 = extractvalue { ptr, i32 } %23, 1
  %26 = getelementptr inbounds { ptr, i32 }, ptr %0, i32 0, i32 0
  store ptr %24, ptr %26, align 8
  %27 = getelementptr inbounds { ptr, i32 }, ptr %0, i32 0, i32 1
  store i32 %25, ptr %27, align 8
  br label %bb20

bb13:                                             ; preds = %bb9
  %28 = load i32, ptr %_22, align 4, !noundef !4
  %29 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %28, i32 1)
  %_24.0 = extractvalue { i32, i1 } %29, 0
  %_24.1 = extractvalue { i32, i1 } %29, 1
  %30 = call i1 @llvm.expect.i1(i1 %_24.1, i1 false)
  br i1 %30, label %panic2, label %bb14

bb14:                                             ; preds = %bb13
  store i32 %_24.0, ptr %_22, align 4
; invoke <std::sync::mutex::MutexGuard<T> as core::ops::deref::Deref>::deref
  %_33 = invoke align 4 ptr @"_ZN81_$LT$std..sync..mutex..MutexGuard$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17h227d4445021e35b1E"(ptr align 8 %no_deadlock)
          to label %bb15 unwind label %cleanup1

panic2:                                           ; preds = %bb13
; invoke core::panicking::panic
  invoke void @_ZN4core9panicking5panic17h39466a6143e26d57E(ptr align 1 @str.2, i64 28, ptr align 8 @alloc_b4883070d3fe8f66aa6794d613ff23cf) #11
          to label %unreachable unwind label %cleanup1

bb15:                                             ; preds = %bb14
; invoke core::fmt::ArgumentV1::new_display
  %31 = invoke { ptr, ptr } @_ZN4core3fmt10ArgumentV111new_display17h94aab3924589f579E(ptr align 4 %_33)
          to label %bb16 unwind label %cleanup1

bb16:                                             ; preds = %bb15
  %_31.0 = extractvalue { ptr, ptr } %31, 0
  %_31.1 = extractvalue { ptr, ptr } %31, 1
  %32 = getelementptr inbounds [1 x { ptr, ptr }], ptr %_30, i64 0, i64 0
  %33 = getelementptr inbounds { ptr, ptr }, ptr %32, i32 0, i32 0
  store ptr %_31.0, ptr %33, align 8
  %34 = getelementptr inbounds { ptr, ptr }, ptr %32, i32 0, i32 1
  store ptr %_31.1, ptr %34, align 8
; invoke core::fmt::Arguments::new_v1
  invoke void @_ZN4core3fmt9Arguments6new_v117hbeeec5b14b13e1aeE(ptr sret(%"core::fmt::Arguments<'_>") %_26, ptr align 8 @alloc_6c0b352bf037327c8a6344d3eb82ea55, i64 2, ptr align 8 %_30, i64 1)
          to label %bb17 unwind label %cleanup1

bb17:                                             ; preds = %bb16
; invoke std::io::stdio::_print
  invoke void @_ZN3std2io5stdio6_print17he1fd6c9db1efbff1E(ptr %_26)
          to label %bb18 unwind label %cleanup1

bb18:                                             ; preds = %bb17
; call core::ptr::drop_in_place<std::sync::mutex::MutexGuard<i32>>
  call void @"_ZN4core3ptr60drop_in_place$LT$std..sync..mutex..MutexGuard$LT$i32$GT$$GT$17hd61a238c527ba340E"(ptr %no_deadlock)
  ret void
}

; std::rt::lang_start_internal
; Function Attrs: nonlazybind uwtable
declare i64 @_ZN3std2rt19lang_start_internal17ha24935c91c6c3a61E(ptr align 1, ptr align 8, i64, ptr, i8) unnamed_addr #1

; std::sys::unix::locks::futex_mutex::Mutex::lock_contended
; Function Attrs: cold nonlazybind uwtable
declare void @_ZN3std3sys4unix5locks11futex_mutex5Mutex14lock_contended17hdc3d388df0205cf0E(ptr align 4) unnamed_addr #3

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #4

; std::panicking::panic_count::is_zero_slow_path
; Function Attrs: cold noinline nonlazybind uwtable
declare zeroext i1 @_ZN3std9panicking11panic_count17is_zero_slow_path17h1811f0c0aba3e0a6E() unnamed_addr #5

; core::fmt::num::imp::<impl core::fmt::Display for i32>::fmt
; Function Attrs: nonlazybind uwtable
declare zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h2d0a9332273b8593E"(ptr align 4, ptr align 8) unnamed_addr #1

; core::panicking::panic_fmt
; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core9panicking9panic_fmt17h9ed84968eba0b8baE(ptr, ptr align 8) unnamed_addr #6

; Function Attrs: nonlazybind uwtable
declare i32 @rust_eh_personality(i32, i32, i64, ptr, ptr) unnamed_addr #1

; core::result::unwrap_failed
; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core6result13unwrap_failed17h97f3d6d985e2e024E(ptr align 1, i64, ptr align 1, ptr align 8, ptr align 8) unnamed_addr #6

; core::panicking::panic_cannot_unwind
; Function Attrs: cold noinline noreturn nounwind nonlazybind uwtable
declare void @_ZN4core9panicking19panic_cannot_unwind17h0f19cb8e77aed642E() unnamed_addr #7

; core::fmt::Formatter::debug_struct
; Function Attrs: nonlazybind uwtable
declare void @_ZN4core3fmt9Formatter12debug_struct17hbeabf85a045ca3ccE(ptr sret(%"core::fmt::builders::DebugStruct<'_, '_>"), ptr align 8, ptr align 1, i64) unnamed_addr #1

; core::fmt::builders::DebugStruct::finish_non_exhaustive
; Function Attrs: nonlazybind uwtable
declare zeroext i1 @_ZN4core3fmt8builders11DebugStruct21finish_non_exhaustive17h36033f4c55f69fc1E(ptr align 8) unnamed_addr #1

; std::sys::unix::locks::futex_mutex::Mutex::wake
; Function Attrs: cold nonlazybind uwtable
declare void @_ZN3std3sys4unix5locks11futex_mutex5Mutex4wake17h282fa8427e64b89aE(ptr align 4) unnamed_addr #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i32, i1 } @llvm.sadd.with.overflow.i32(i32, i32) #8

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i1 @llvm.expect.i1(i1, i1) #9

; core::panicking::panic
; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_ZN4core9panicking5panic17h39466a6143e26d57E(ptr align 1, i64, ptr align 8) unnamed_addr #6

; std::io::stdio::_print
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std2io5stdio6_print17he1fd6c9db1efbff1E(ptr) unnamed_addr #1

; Function Attrs: nonlazybind
define i32 @main(i32 %0, ptr %1) unnamed_addr #10 {
top:
  %2 = sext i32 %0 to i64
; call std::rt::lang_start
  %3 = call i64 @_ZN3std2rt10lang_start17h320d0e6e2a6b7c06E(ptr @_ZN17locks_no_deadlock4main17h9920d0e889717c87E, i64 %2, ptr %1, i8 0)
  %4 = trunc i64 %3 to i32
  ret i32 %4
}

attributes #0 = { noinline nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #1 = { nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #2 = { inlinehint nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #3 = { cold nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { cold noinline nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #6 = { cold noinline noreturn nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #7 = { cold noinline noreturn nounwind nonlazybind uwtable "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #10 = { nonlazybind "target-cpu"="generic" }
attributes #11 = { noreturn }
attributes #12 = { noinline }
attributes #13 = { noinline noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 7, !"PIE Level", i32 2}
!2 = !{i32 2, !"RtLibUseGOT", i32 1}
!3 = !{i32 2174151}
!4 = !{}
!5 = !{i32 0, i32 2}
!6 = !{i8 0, i8 2}
!7 = !{i64 4}
!8 = !{i64 1}
!9 = !{i64 8}
!10 = !{i8 0, i8 5}
!11 = !{i64 0, i64 2}
