; ModuleID = 'prog.opt.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

@.str = private constant [8 x i8] c"in_data\00"
@.str1 = private constant [9 x i8] c"out_data\00"

define float @fpmul32f(float %x, float %y) nounwind readnone {
  %1 = fmul float %x, %y
  ret float %1
}

define float @fpadd32f(float %x, float %y) nounwind readnone {
  %1 = fadd float %x, %y
  ret float %1
}

define float @fpsub32f(float %x, float %y) nounwind readnone {
  %1 = fsub float %x, %y
  ret float %1
}

define i32 @fpadd32fi(i32 %x, i32 %y) nounwind readnone {
  %1 = add i32 %y, %x
  ret i32 %1
}

define i32 @fpsub32fi(i32 %x, i32 %y) nounwind readnone {
  %1 = sub i32 %x, %y
  ret i32 %1
}

define i32 @udiv32(i32 %dividend, i32 %divisor) nounwind readnone {
; <label>:0
  switch i32 %divisor, label %2 [
    i32 0, label %.loopexit
    i32 1, label %1
  ]

; <label>:1                                       ; preds = %0
  ret i32 %dividend

; <label>:2                                       ; preds = %0
  %3 = icmp ugt i32 %divisor, %dividend
  %4 = icmp ult i32 %dividend, %divisor
  %or.cond = or i1 %3, %4
  br i1 %or.cond, label %.loopexit, label %bb.nph7.preheader

bb.nph7.preheader:                                ; preds = %2
  br label %bb.nph7

bb.nph7:                                          ; preds = %._crit_edge, %bb.nph7.preheader
  %.016 = phi i32 [ %11, %._crit_edge ], [ %dividend, %bb.nph7.preheader ]
  %quotient.05 = phi i32 [ %10, %._crit_edge ], [ 0, %bb.nph7.preheader ]
  %5 = lshr i32 %.016, 1
  %6 = icmp ugt i32 %5, %divisor
  br i1 %6, label %bb.nph.preheader, label %._crit_edge

bb.nph.preheader:                                 ; preds = %bb.nph7
  br label %bb.nph

bb.nph:                                           ; preds = %bb.nph, %bb.nph.preheader
  %shifted_divisor.03 = phi i32 [ %7, %bb.nph ], [ %divisor, %bb.nph.preheader ]
  %curr_quotient.02 = phi i32 [ %8, %bb.nph ], [ 1, %bb.nph.preheader ]
  %7 = shl i32 %shifted_divisor.03, 1
  %8 = shl i32 %curr_quotient.02, 1
  %9 = icmp ult i32 %7, %5
  br i1 %9, label %bb.nph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %bb.nph
  %.lcssa1 = phi i32 [ %8, %bb.nph ]
  %.lcssa = phi i32 [ %7, %bb.nph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %bb.nph7
  %shifted_divisor.0.lcssa = phi i32 [ %divisor, %bb.nph7 ], [ %.lcssa, %._crit_edge.loopexit ]
  %curr_quotient.0.lcssa = phi i32 [ 1, %bb.nph7 ], [ %.lcssa1, %._crit_edge.loopexit ]
  %10 = add i32 %curr_quotient.0.lcssa, %quotient.05
  %11 = sub i32 %.016, %shifted_divisor.0.lcssa
  %12 = icmp ult i32 %11, %divisor
  br i1 %12, label %.loopexit.loopexit, label %bb.nph7

.loopexit.loopexit:                               ; preds = %._crit_edge
  %.lcssa2 = phi i32 [ %10, %._crit_edge ]
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2, %0
  %.0 = phi i32 [ -1, %0 ], [ 0, %2 ], [ %.lcssa2, %.loopexit.loopexit ]
  ret i32 %.0
}

define float @fdiv32(float %a, float %b) nounwind readnone {
  %tmp10 = bitcast float %a to i32
  %tmp6 = bitcast float %b to i32
  %1 = fcmp oeq float %a, 0.000000e+00
  br i1 %1, label %37, label %2

; <label>:2                                       ; preds = %0
  %3 = lshr i32 %tmp10, 23
  %4 = and i32 %3, 255
  %5 = lshr i32 %tmp6, 23
  %6 = and i32 %5, 255
  %7 = shl i32 %tmp10, 7
  %8 = and i32 %7, 1073741696
  %9 = or i32 %8, 1073741824
  %10 = lshr i32 %tmp6, 7
  %11 = and i32 %10, 65535
  %12 = or i32 %11, 65536
  %13 = xor i32 %tmp6, %tmp10
  %14 = and i32 %13, -2147483648
  %15 = sub i32 %4, %6
  switch i32 %12, label %bb.nph7.i.preheader [
    i32 0, label %.loopexit.i
    i32 1, label %udiv32.exit.preheader
  ]

bb.nph7.i.preheader:                              ; preds = %2
  br label %bb.nph7.i

bb.nph7.i:                                        ; preds = %._crit_edge.i, %bb.nph7.i.preheader
  %.016.i = phi i32 [ %22, %._crit_edge.i ], [ %9, %bb.nph7.i.preheader ]
  %quotient.05.i = phi i32 [ %21, %._crit_edge.i ], [ 0, %bb.nph7.i.preheader ]
  %16 = lshr i32 %.016.i, 1
  %17 = icmp ugt i32 %16, %12
  br i1 %17, label %bb.nph.i.preheader, label %._crit_edge.i

bb.nph.i.preheader:                               ; preds = %bb.nph7.i
  br label %bb.nph.i

bb.nph.i:                                         ; preds = %bb.nph.i, %bb.nph.i.preheader
  %shifted_divisor.03.i = phi i32 [ %18, %bb.nph.i ], [ %12, %bb.nph.i.preheader ]
  %curr_quotient.02.i = phi i32 [ %19, %bb.nph.i ], [ 1, %bb.nph.i.preheader ]
  %18 = shl i32 %shifted_divisor.03.i, 1
  %19 = shl i32 %curr_quotient.02.i, 1
  %20 = icmp ult i32 %18, %16
  br i1 %20, label %bb.nph.i, label %._crit_edge.i.loopexit

._crit_edge.i.loopexit:                           ; preds = %bb.nph.i
  %.lcssa2 = phi i32 [ %19, %bb.nph.i ]
  %.lcssa1 = phi i32 [ %18, %bb.nph.i ]
  br label %._crit_edge.i

._crit_edge.i:                                    ; preds = %._crit_edge.i.loopexit, %bb.nph7.i
  %shifted_divisor.0.lcssa.i = phi i32 [ %12, %bb.nph7.i ], [ %.lcssa1, %._crit_edge.i.loopexit ]
  %curr_quotient.0.lcssa.i = phi i32 [ 1, %bb.nph7.i ], [ %.lcssa2, %._crit_edge.i.loopexit ]
  %21 = add i32 %curr_quotient.0.lcssa.i, %quotient.05.i
  %22 = sub i32 %.016.i, %shifted_divisor.0.lcssa.i
  %23 = icmp ult i32 %22, %12
  br i1 %23, label %.loopexit.i.loopexit, label %bb.nph7.i

.loopexit.i.loopexit:                             ; preds = %._crit_edge.i
  %.lcssa3 = phi i32 [ %21, %._crit_edge.i ]
  br label %.loopexit.i

.loopexit.i:                                      ; preds = %.loopexit.i.loopexit, %2
  %.0.i = phi i32 [ -1, %2 ], [ %.lcssa3, %.loopexit.i.loopexit ]
  br label %udiv32.exit.preheader

udiv32.exit.preheader:                            ; preds = %.loopexit.i, %2
  %temp.0.ph = phi i32 [ %.0.i, %.loopexit.i ], [ %9, %2 ]
  %24 = and i32 %temp.0.ph, 8388608
  %25 = icmp eq i32 %24, 0
  %26 = icmp ne i32 %temp.0.ph, 0
  %or.cond11 = and i1 %25, %26
  br i1 %or.cond11, label %bb.nph, label %.critedge

bb.nph:                                           ; preds = %udiv32.exit.preheader
  %tmp21 = add i32 %4, -1
  br label %udiv32.exit

udiv32.exit:                                      ; preds = %udiv32.exit, %bb.nph
  %27 = phi i32 [ 0, %bb.nph ], [ %indvar.next, %udiv32.exit ]
  %temp.012 = phi i32 [ %temp.0.ph, %bb.nph ], [ %28, %udiv32.exit ]
  %28 = shl i32 %temp.012, 1
  %29 = and i32 %28, 8388608
  %30 = icmp eq i32 %29, 0
  %31 = icmp ne i32 %28, 0
  %or.cond = and i1 %30, %31
  %indvar.next = add i32 %27, 1
  br i1 %or.cond, label %udiv32.exit, label %udiv32.exit..critedge_crit_edge

udiv32.exit..critedge_crit_edge:                  ; preds = %udiv32.exit
  %.lcssa = phi i32 [ %28, %udiv32.exit ]
  %indvar.lcssa = phi i32 [ %27, %udiv32.exit ]
  %tmp25 = sub i32 %tmp21, %6
  %tmp26 = sub i32 %tmp25, %indvar.lcssa
  br label %.critedge

.critedge:                                        ; preds = %udiv32.exit..critedge_crit_edge, %udiv32.exit.preheader
  %exp.0.lcssa = phi i32 [ %tmp26, %udiv32.exit..critedge_crit_edge ], [ %15, %udiv32.exit.preheader ]
  %temp.0.lcssa = phi i32 [ %.lcssa, %udiv32.exit..critedge_crit_edge ], [ %temp.0.ph, %udiv32.exit.preheader ]
  %32 = and i32 %temp.0.lcssa, 8388607
  %33 = shl i32 %exp.0.lcssa, 23
  %34 = add i32 %33, 1140850688
  %35 = or i32 %32, %14
  %36 = or i32 %35, %34
  %tmp3 = bitcast i32 %36 to float
  ret float %tmp3

; <label>:37                                      ; preds = %0
  ret float 0.000000e+00
}

define float @rotor_flux_calc(float %del_t, float %Lm, float %id, float %flux_rotor_prev, float %tau_new, float %tau_r) nounwind readnone {
  %1 = fmul float %Lm, 5.000000e+01
  %2 = fmul float %1, %id
  %3 = fmul float %flux_rotor_prev, 0x4059FADD40000000
  %4 = fadd float %3, %2
  %tmp10.i = bitcast float %4 to i32
  %5 = fcmp oeq float %4, 0.000000e+00
  br i1 %5, label %fdiv32.exit, label %6

; <label>:6                                       ; preds = %0
  %7 = shl i32 %tmp10.i, 7
  %8 = and i32 %7, 1073741696
  %9 = or i32 %8, 1073741824
  br label %bb.nph7.i.i

bb.nph7.i.i:                                      ; preds = %._crit_edge.i.i, %6
  %.016.i.i = phi i32 [ %16, %._crit_edge.i.i ], [ %9, %6 ]
  %quotient.05.i.i = phi i32 [ %15, %._crit_edge.i.i ], [ 0, %6 ]
  %10 = lshr i32 %.016.i.i, 1
  %11 = icmp ugt i32 %10, 106465
  br i1 %11, label %bb.nph.i.i.preheader, label %._crit_edge.i.i

bb.nph.i.i.preheader:                             ; preds = %bb.nph7.i.i
  br label %bb.nph.i.i

bb.nph.i.i:                                       ; preds = %bb.nph.i.i, %bb.nph.i.i.preheader
  %shifted_divisor.03.i.i = phi i32 [ %12, %bb.nph.i.i ], [ 106465, %bb.nph.i.i.preheader ]
  %curr_quotient.02.i.i = phi i32 [ %13, %bb.nph.i.i ], [ 1, %bb.nph.i.i.preheader ]
  %12 = shl i32 %shifted_divisor.03.i.i, 1
  %13 = shl i32 %curr_quotient.02.i.i, 1
  %14 = icmp ult i32 %12, %10
  br i1 %14, label %bb.nph.i.i, label %._crit_edge.i.i.loopexit

._crit_edge.i.i.loopexit:                         ; preds = %bb.nph.i.i
  %.lcssa3 = phi i32 [ %13, %bb.nph.i.i ]
  %.lcssa2 = phi i32 [ %12, %bb.nph.i.i ]
  br label %._crit_edge.i.i

._crit_edge.i.i:                                  ; preds = %._crit_edge.i.i.loopexit, %bb.nph7.i.i
  %shifted_divisor.0.lcssa.i.i = phi i32 [ 106465, %bb.nph7.i.i ], [ %.lcssa2, %._crit_edge.i.i.loopexit ]
  %curr_quotient.0.lcssa.i.i = phi i32 [ 1, %bb.nph7.i.i ], [ %.lcssa3, %._crit_edge.i.i.loopexit ]
  %15 = add i32 %curr_quotient.0.lcssa.i.i, %quotient.05.i.i
  %16 = sub i32 %.016.i.i, %shifted_divisor.0.lcssa.i.i
  %17 = icmp ult i32 %16, 106465
  br i1 %17, label %udiv32.exit.preheader.i, label %bb.nph7.i.i

udiv32.exit.preheader.i:                          ; preds = %._crit_edge.i.i
  %.lcssa4 = phi i32 [ %15, %._crit_edge.i.i ]
  %18 = lshr i32 %tmp10.i, 23
  %19 = and i32 %tmp10.i, -2147483648
  %20 = and i32 %18, 255
  %21 = add i32 %20, -133
  %22 = and i32 %.lcssa4, 8388608
  %23 = icmp eq i32 %22, 0
  %24 = icmp ne i32 %.lcssa4, 0
  %or.cond11.i = and i1 %23, %24
  br i1 %or.cond11.i, label %udiv32.exit.i.preheader, label %.critedge.i

udiv32.exit.i.preheader:                          ; preds = %udiv32.exit.preheader.i
  br label %udiv32.exit.i

udiv32.exit.i:                                    ; preds = %udiv32.exit.i, %udiv32.exit.i.preheader
  %25 = phi i32 [ %indvar.next.i, %udiv32.exit.i ], [ 0, %udiv32.exit.i.preheader ]
  %temp.012.i = phi i32 [ %26, %udiv32.exit.i ], [ %.lcssa4, %udiv32.exit.i.preheader ]
  %26 = shl i32 %temp.012.i, 1
  %27 = and i32 %26, 8388608
  %28 = icmp eq i32 %27, 0
  %29 = icmp ne i32 %26, 0
  %or.cond.i = and i1 %28, %29
  %indvar.next.i = add i32 %25, 1
  br i1 %or.cond.i, label %udiv32.exit.i, label %udiv32.exit..critedge_crit_edge.i

udiv32.exit..critedge_crit_edge.i:                ; preds = %udiv32.exit.i
  %.lcssa1 = phi i32 [ %26, %udiv32.exit.i ]
  %.lcssa = phi i32 [ %25, %udiv32.exit.i ]
  %tmp25.i = add i32 %20, -134
  %tmp26.i = sub i32 %tmp25.i, %.lcssa
  br label %.critedge.i

.critedge.i:                                      ; preds = %udiv32.exit..critedge_crit_edge.i, %udiv32.exit.preheader.i
  %exp.0.lcssa.i = phi i32 [ %tmp26.i, %udiv32.exit..critedge_crit_edge.i ], [ %21, %udiv32.exit.preheader.i ]
  %temp.0.lcssa.i = phi i32 [ %.lcssa1, %udiv32.exit..critedge_crit_edge.i ], [ %.lcssa4, %udiv32.exit.preheader.i ]
  %30 = and i32 %temp.0.lcssa.i, 8388607
  %31 = shl i32 %exp.0.lcssa.i, 23
  %32 = add i32 %31, 1140850688
  %33 = or i32 %32, %19
  %34 = or i32 %33, %30
  %tmp3.i = bitcast i32 %34 to float
  ret float %tmp3.i

fdiv32.exit:                                      ; preds = %0
  ret float 0.000000e+00
}

define float @omega_calc(float %Lm, float %iq, float %tau_r, float %flux_rotor) nounwind readnone {
  %1 = fmul float %Lm, %iq
  %2 = fmul float %tau_r, %flux_rotor
  %tmp10.i = bitcast float %1 to i32
  %tmp6.i = bitcast float %2 to i32
  %3 = fcmp oeq float %1, 0.000000e+00
  br i1 %3, label %fdiv32.exit, label %4

; <label>:4                                       ; preds = %0
  %5 = lshr i32 %tmp10.i, 23
  %6 = and i32 %5, 255
  %7 = lshr i32 %tmp6.i, 23
  %8 = and i32 %7, 255
  %9 = shl i32 %tmp10.i, 7
  %10 = and i32 %9, 1073741696
  %11 = or i32 %10, 1073741824
  %12 = lshr i32 %tmp6.i, 7
  %13 = and i32 %12, 65535
  %14 = or i32 %13, 65536
  %15 = xor i32 %tmp6.i, %tmp10.i
  %16 = and i32 %15, -2147483648
  %17 = sub i32 %6, %8
  switch i32 %14, label %bb.nph7.i.i.preheader [
    i32 0, label %.loopexit.i.i
    i32 1, label %udiv32.exit.preheader.i
  ]

bb.nph7.i.i.preheader:                            ; preds = %4
  br label %bb.nph7.i.i

bb.nph7.i.i:                                      ; preds = %._crit_edge.i.i, %bb.nph7.i.i.preheader
  %.016.i.i = phi i32 [ %24, %._crit_edge.i.i ], [ %11, %bb.nph7.i.i.preheader ]
  %quotient.05.i.i = phi i32 [ %23, %._crit_edge.i.i ], [ 0, %bb.nph7.i.i.preheader ]
  %18 = lshr i32 %.016.i.i, 1
  %19 = icmp ugt i32 %18, %14
  br i1 %19, label %bb.nph.i.i.preheader, label %._crit_edge.i.i

bb.nph.i.i.preheader:                             ; preds = %bb.nph7.i.i
  br label %bb.nph.i.i

bb.nph.i.i:                                       ; preds = %bb.nph.i.i, %bb.nph.i.i.preheader
  %shifted_divisor.03.i.i = phi i32 [ %20, %bb.nph.i.i ], [ %14, %bb.nph.i.i.preheader ]
  %curr_quotient.02.i.i = phi i32 [ %21, %bb.nph.i.i ], [ 1, %bb.nph.i.i.preheader ]
  %20 = shl i32 %shifted_divisor.03.i.i, 1
  %21 = shl i32 %curr_quotient.02.i.i, 1
  %22 = icmp ult i32 %20, %18
  br i1 %22, label %bb.nph.i.i, label %._crit_edge.i.i.loopexit

._crit_edge.i.i.loopexit:                         ; preds = %bb.nph.i.i
  %.lcssa3 = phi i32 [ %21, %bb.nph.i.i ]
  %.lcssa2 = phi i32 [ %20, %bb.nph.i.i ]
  br label %._crit_edge.i.i

._crit_edge.i.i:                                  ; preds = %._crit_edge.i.i.loopexit, %bb.nph7.i.i
  %shifted_divisor.0.lcssa.i.i = phi i32 [ %14, %bb.nph7.i.i ], [ %.lcssa2, %._crit_edge.i.i.loopexit ]
  %curr_quotient.0.lcssa.i.i = phi i32 [ 1, %bb.nph7.i.i ], [ %.lcssa3, %._crit_edge.i.i.loopexit ]
  %23 = add i32 %curr_quotient.0.lcssa.i.i, %quotient.05.i.i
  %24 = sub i32 %.016.i.i, %shifted_divisor.0.lcssa.i.i
  %25 = icmp ult i32 %24, %14
  br i1 %25, label %.loopexit.i.i.loopexit, label %bb.nph7.i.i

.loopexit.i.i.loopexit:                           ; preds = %._crit_edge.i.i
  %.lcssa4 = phi i32 [ %23, %._crit_edge.i.i ]
  br label %.loopexit.i.i

.loopexit.i.i:                                    ; preds = %.loopexit.i.i.loopexit, %4
  %.0.i.i = phi i32 [ -1, %4 ], [ %.lcssa4, %.loopexit.i.i.loopexit ]
  br label %udiv32.exit.preheader.i

udiv32.exit.preheader.i:                          ; preds = %.loopexit.i.i, %4
  %temp.0.ph.i = phi i32 [ %.0.i.i, %.loopexit.i.i ], [ %11, %4 ]
  %26 = and i32 %temp.0.ph.i, 8388608
  %27 = icmp eq i32 %26, 0
  %28 = icmp ne i32 %temp.0.ph.i, 0
  %or.cond11.i = and i1 %27, %28
  br i1 %or.cond11.i, label %udiv32.exit.i.preheader, label %.critedge.i

udiv32.exit.i.preheader:                          ; preds = %udiv32.exit.preheader.i
  br label %udiv32.exit.i

udiv32.exit.i:                                    ; preds = %udiv32.exit.i, %udiv32.exit.i.preheader
  %29 = phi i32 [ %indvar.next.i, %udiv32.exit.i ], [ 0, %udiv32.exit.i.preheader ]
  %temp.012.i = phi i32 [ %30, %udiv32.exit.i ], [ %temp.0.ph.i, %udiv32.exit.i.preheader ]
  %30 = shl i32 %temp.012.i, 1
  %31 = and i32 %30, 8388608
  %32 = icmp eq i32 %31, 0
  %33 = icmp ne i32 %30, 0
  %or.cond.i = and i1 %32, %33
  %indvar.next.i = add i32 %29, 1
  br i1 %or.cond.i, label %udiv32.exit.i, label %udiv32.exit..critedge_crit_edge.i

udiv32.exit..critedge_crit_edge.i:                ; preds = %udiv32.exit.i
  %.lcssa1 = phi i32 [ %30, %udiv32.exit.i ]
  %.lcssa = phi i32 [ %29, %udiv32.exit.i ]
  %tmp21.i = add i32 %6, -1
  %tmp25.i = sub i32 %tmp21.i, %8
  %tmp26.i = sub i32 %tmp25.i, %.lcssa
  br label %.critedge.i

.critedge.i:                                      ; preds = %udiv32.exit..critedge_crit_edge.i, %udiv32.exit.preheader.i
  %exp.0.lcssa.i = phi i32 [ %tmp26.i, %udiv32.exit..critedge_crit_edge.i ], [ %17, %udiv32.exit.preheader.i ]
  %temp.0.lcssa.i = phi i32 [ %.lcssa1, %udiv32.exit..critedge_crit_edge.i ], [ %temp.0.ph.i, %udiv32.exit.preheader.i ]
  %34 = and i32 %temp.0.lcssa.i, 8388607
  %35 = shl i32 %exp.0.lcssa.i, 23
  %36 = add i32 %35, 1140850688
  %37 = or i32 %36, %16
  %38 = or i32 %37, %34
  %tmp3.i = bitcast i32 %38 to float
  ret float %tmp3.i

fdiv32.exit:                                      ; preds = %0
  ret float 0.000000e+00
}

define float @theta_calc(float %omega_r, float %omega_m, float %del_t, float %theta_prev) nounwind readnone {
  %1 = fmul float %omega_r, %omega_m
  %2 = fadd float %1, %theta_prev
  ret float %2
}

define float @iq_err_calc(float %Lr, float %torque_ref, float %constant_1, float %flux_rotor) nounwind readnone {
  %1 = fcmp olt float %flux_rotor, 1.000000e+00
  %.0 = select i1 %1, float 1.000000e+00, float %flux_rotor
  %2 = fmul float %Lr, 2.000000e+03
  %3 = fmul float %2, %torque_ref
  %4 = fmul float %.0, %constant_1
  %tmp10.i = bitcast float %3 to i32
  %tmp6.i = bitcast float %4 to i32
  %5 = fcmp oeq float %3, 0.000000e+00
  br i1 %5, label %fdiv32.exit, label %6

; <label>:6                                       ; preds = %0
  %7 = lshr i32 %tmp10.i, 23
  %8 = and i32 %7, 255
  %9 = lshr i32 %tmp6.i, 23
  %10 = and i32 %9, 255
  %11 = shl i32 %tmp10.i, 7
  %12 = and i32 %11, 1073741696
  %13 = or i32 %12, 1073741824
  %14 = lshr i32 %tmp6.i, 7
  %15 = and i32 %14, 65535
  %16 = or i32 %15, 65536
  %17 = xor i32 %tmp6.i, %tmp10.i
  %18 = and i32 %17, -2147483648
  %19 = sub i32 %8, %10
  switch i32 %16, label %bb.nph7.i.i.preheader [
    i32 0, label %.loopexit.i.i
    i32 1, label %udiv32.exit.preheader.i
  ]

bb.nph7.i.i.preheader:                            ; preds = %6
  br label %bb.nph7.i.i

bb.nph7.i.i:                                      ; preds = %._crit_edge.i.i, %bb.nph7.i.i.preheader
  %.016.i.i = phi i32 [ %26, %._crit_edge.i.i ], [ %13, %bb.nph7.i.i.preheader ]
  %quotient.05.i.i = phi i32 [ %25, %._crit_edge.i.i ], [ 0, %bb.nph7.i.i.preheader ]
  %20 = lshr i32 %.016.i.i, 1
  %21 = icmp ugt i32 %20, %16
  br i1 %21, label %bb.nph.i.i.preheader, label %._crit_edge.i.i

bb.nph.i.i.preheader:                             ; preds = %bb.nph7.i.i
  br label %bb.nph.i.i

bb.nph.i.i:                                       ; preds = %bb.nph.i.i, %bb.nph.i.i.preheader
  %shifted_divisor.03.i.i = phi i32 [ %22, %bb.nph.i.i ], [ %16, %bb.nph.i.i.preheader ]
  %curr_quotient.02.i.i = phi i32 [ %23, %bb.nph.i.i ], [ 1, %bb.nph.i.i.preheader ]
  %22 = shl i32 %shifted_divisor.03.i.i, 1
  %23 = shl i32 %curr_quotient.02.i.i, 1
  %24 = icmp ult i32 %22, %20
  br i1 %24, label %bb.nph.i.i, label %._crit_edge.i.i.loopexit

._crit_edge.i.i.loopexit:                         ; preds = %bb.nph.i.i
  %.lcssa3 = phi i32 [ %23, %bb.nph.i.i ]
  %.lcssa2 = phi i32 [ %22, %bb.nph.i.i ]
  br label %._crit_edge.i.i

._crit_edge.i.i:                                  ; preds = %._crit_edge.i.i.loopexit, %bb.nph7.i.i
  %shifted_divisor.0.lcssa.i.i = phi i32 [ %16, %bb.nph7.i.i ], [ %.lcssa2, %._crit_edge.i.i.loopexit ]
  %curr_quotient.0.lcssa.i.i = phi i32 [ 1, %bb.nph7.i.i ], [ %.lcssa3, %._crit_edge.i.i.loopexit ]
  %25 = add i32 %curr_quotient.0.lcssa.i.i, %quotient.05.i.i
  %26 = sub i32 %.016.i.i, %shifted_divisor.0.lcssa.i.i
  %27 = icmp ult i32 %26, %16
  br i1 %27, label %.loopexit.i.i.loopexit, label %bb.nph7.i.i

.loopexit.i.i.loopexit:                           ; preds = %._crit_edge.i.i
  %.lcssa4 = phi i32 [ %25, %._crit_edge.i.i ]
  br label %.loopexit.i.i

.loopexit.i.i:                                    ; preds = %.loopexit.i.i.loopexit, %6
  %.0.i.i = phi i32 [ -1, %6 ], [ %.lcssa4, %.loopexit.i.i.loopexit ]
  br label %udiv32.exit.preheader.i

udiv32.exit.preheader.i:                          ; preds = %.loopexit.i.i, %6
  %temp.0.ph.i = phi i32 [ %.0.i.i, %.loopexit.i.i ], [ %13, %6 ]
  %28 = and i32 %temp.0.ph.i, 8388608
  %29 = icmp eq i32 %28, 0
  %30 = icmp ne i32 %temp.0.ph.i, 0
  %or.cond11.i = and i1 %29, %30
  br i1 %or.cond11.i, label %udiv32.exit.i.preheader, label %.critedge.i

udiv32.exit.i.preheader:                          ; preds = %udiv32.exit.preheader.i
  br label %udiv32.exit.i

udiv32.exit.i:                                    ; preds = %udiv32.exit.i, %udiv32.exit.i.preheader
  %31 = phi i32 [ %indvar.next.i, %udiv32.exit.i ], [ 0, %udiv32.exit.i.preheader ]
  %temp.012.i = phi i32 [ %32, %udiv32.exit.i ], [ %temp.0.ph.i, %udiv32.exit.i.preheader ]
  %32 = shl i32 %temp.012.i, 1
  %33 = and i32 %32, 8388608
  %34 = icmp eq i32 %33, 0
  %35 = icmp ne i32 %32, 0
  %or.cond.i = and i1 %34, %35
  %indvar.next.i = add i32 %31, 1
  br i1 %or.cond.i, label %udiv32.exit.i, label %udiv32.exit..critedge_crit_edge.i

udiv32.exit..critedge_crit_edge.i:                ; preds = %udiv32.exit.i
  %.lcssa1 = phi i32 [ %32, %udiv32.exit.i ]
  %.lcssa = phi i32 [ %31, %udiv32.exit.i ]
  %tmp21.i = add i32 %8, -1
  %tmp25.i = sub i32 %tmp21.i, %10
  %tmp26.i = sub i32 %tmp25.i, %.lcssa
  br label %.critedge.i

.critedge.i:                                      ; preds = %udiv32.exit..critedge_crit_edge.i, %udiv32.exit.preheader.i
  %exp.0.lcssa.i = phi i32 [ %tmp26.i, %udiv32.exit..critedge_crit_edge.i ], [ %19, %udiv32.exit.preheader.i ]
  %temp.0.lcssa.i = phi i32 [ %.lcssa1, %udiv32.exit..critedge_crit_edge.i ], [ %temp.0.ph.i, %udiv32.exit.preheader.i ]
  %36 = and i32 %temp.0.lcssa.i, 8388607
  %37 = shl i32 %exp.0.lcssa.i, 23
  %38 = add i32 %37, 1140850688
  %39 = or i32 %38, %18
  %40 = or i32 %39, %36
  %tmp3.i = bitcast i32 %40 to float
  ret float %tmp3.i

fdiv32.exit:                                      ; preds = %0
  ret float 0.000000e+00
}

define void @vector_control_daemon() noreturn nounwind {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %fdiv32.exit, %0
  %flux_rotor_prev.0 = phi float [ 0.000000e+00, %0 ], [ %75, %fdiv32.exit ]
  %theta_prev.0 = phi float [ 0.000000e+00, %0 ], [ %115, %fdiv32.exit ]
  %int_flux_err.0 = phi float [ 0.000000e+00, %0 ], [ %int_flux_err.1, %fdiv32.exit ]
  %int_speed_err.0 = phi float [ 0.000000e+00, %0 ], [ %int_speed_err.1, %fdiv32.exit ]
  %2 = tail call float @read_float32(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0)) nounwind
  %3 = tail call float @read_float32(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0)) nounwind
  %4 = tail call float @read_float32(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0)) nounwind
  %5 = tail call float @read_float32(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0)) nounwind
  %6 = fsub float %5, %4
  %7 = fmul float %6, 0x3F0A36E2E0000000
  %8 = fadd float %7, %int_speed_err.0
  %9 = fmul float %8, 5.000000e+01
  %10 = fpext float %9 to double
  %11 = fcmp olt double %10, -1.500000e+01
  br i1 %11, label %15, label %12

; <label>:12                                      ; preds = %1
  %13 = fcmp ogt double %10, 1.500000e+01
  br i1 %13, label %15, label %14

; <label>:14                                      ; preds = %12
  br label %15

; <label>:15                                      ; preds = %14, %12, %1
  %int_speed_err.1 = phi float [ %9, %14 ], [ -1.500000e+01, %1 ], [ 1.500000e+01, %12 ]
  %16 = fmul float %6, 4.000000e+01
  %17 = fadd float %int_speed_err.1, %16
  %18 = fcmp olt float %17, -3.000000e+01
  br i1 %18, label %22, label %19

; <label>:19                                      ; preds = %15
  %20 = fcmp ogt float %17, 3.000000e+01
  br i1 %20, label %22, label %21

; <label>:21                                      ; preds = %19
  %phitmp54 = fmul float %17, 1.683500e+03
  br label %22

; <label>:22                                      ; preds = %21, %19, %15
  %torque_ref.0 = phi float [ %phitmp54, %21 ], [ -5.050500e+04, %15 ], [ 5.050500e+04, %19 ]
  %23 = fpext float %5 to double
  %24 = fcmp ugt double %23, 2.000000e+03
  br i1 %24, label %25, label %41

; <label>:25                                      ; preds = %22
  %26 = fcmp ugt double %23, 2.500000e+03
  br i1 %26, label %31, label %27

; <label>:27                                      ; preds = %25
  %28 = fmul float %5, 0xBF2A36E2E0000000
  %29 = fadd float %28, 0x3FF6666660000000
  %30 = fmul float %29, 3.000000e+02
  br label %41

; <label>:31                                      ; preds = %25
  %32 = fcmp ugt double %23, 3.000000e+03
  br i1 %32, label %37, label %33

; <label>:33                                      ; preds = %31
  %34 = fmul float %5, 0xBF3797CC40000000
  %35 = fadd float %34, 0x3FFCCCCCC0000000
  %36 = fmul float %35, 3.000000e+02
  br label %41

; <label>:37                                      ; preds = %31
  %38 = fmul float %5, 0xBF3B866E40000000
  %39 = fadd float %38, 0x3FFFAE1480000000
  %40 = fmul float %39, 3.000000e+02
  br label %41

; <label>:41                                      ; preds = %37, %33, %27, %22
  %flux_ref.0 = phi float [ %30, %27 ], [ %36, %33 ], [ %40, %37 ], [ 3.000000e+02, %22 ]
  %42 = fmul float %2, 0x40443D70A0000000
  %43 = fmul float %flux_rotor_prev.0, 0x4059FADD40000000
  %44 = fadd float %43, %42
  %tmp10.i.i30 = bitcast float %44 to i32
  %45 = fcmp oeq float %44, 0.000000e+00
  br i1 %45, label %rotor_flux_calc.exit, label %46

; <label>:46                                      ; preds = %41
  %47 = shl i32 %tmp10.i.i30, 7
  %48 = and i32 %47, 1073741696
  %49 = or i32 %48, 1073741824
  br label %bb.nph7.i.i.i33

bb.nph7.i.i.i33:                                  ; preds = %._crit_edge.i.i.i39, %46
  %.016.i.i.i31 = phi i32 [ %56, %._crit_edge.i.i.i39 ], [ %49, %46 ]
  %quotient.05.i.i.i32 = phi i32 [ %55, %._crit_edge.i.i.i39 ], [ 0, %46 ]
  %50 = lshr i32 %.016.i.i.i31, 1
  %51 = icmp ugt i32 %50, 106465
  br i1 %51, label %bb.nph.i.i.i36.preheader, label %._crit_edge.i.i.i39

bb.nph.i.i.i36.preheader:                         ; preds = %bb.nph7.i.i.i33
  br label %bb.nph.i.i.i36

bb.nph.i.i.i36:                                   ; preds = %bb.nph.i.i.i36, %bb.nph.i.i.i36.preheader
  %shifted_divisor.03.i.i.i34 = phi i32 [ %52, %bb.nph.i.i.i36 ], [ 106465, %bb.nph.i.i.i36.preheader ]
  %curr_quotient.02.i.i.i35 = phi i32 [ %53, %bb.nph.i.i.i36 ], [ 1, %bb.nph.i.i.i36.preheader ]
  %52 = shl i32 %shifted_divisor.03.i.i.i34, 1
  %53 = shl i32 %curr_quotient.02.i.i.i35, 1
  %54 = icmp ult i32 %52, %50
  br i1 %54, label %bb.nph.i.i.i36, label %._crit_edge.i.i.i39.loopexit

._crit_edge.i.i.i39.loopexit:                     ; preds = %bb.nph.i.i.i36
  %.lcssa18 = phi i32 [ %53, %bb.nph.i.i.i36 ]
  %.lcssa17 = phi i32 [ %52, %bb.nph.i.i.i36 ]
  br label %._crit_edge.i.i.i39

._crit_edge.i.i.i39:                              ; preds = %._crit_edge.i.i.i39.loopexit, %bb.nph7.i.i.i33
  %shifted_divisor.0.lcssa.i.i.i37 = phi i32 [ 106465, %bb.nph7.i.i.i33 ], [ %.lcssa17, %._crit_edge.i.i.i39.loopexit ]
  %curr_quotient.0.lcssa.i.i.i38 = phi i32 [ 1, %bb.nph7.i.i.i33 ], [ %.lcssa18, %._crit_edge.i.i.i39.loopexit ]
  %55 = add i32 %curr_quotient.0.lcssa.i.i.i38, %quotient.05.i.i.i32
  %56 = sub i32 %.016.i.i.i31, %shifted_divisor.0.lcssa.i.i.i37
  %57 = icmp ult i32 %56, 106465
  br i1 %57, label %udiv32.exit.preheader.i.i41, label %bb.nph7.i.i.i33

udiv32.exit.preheader.i.i41:                      ; preds = %._crit_edge.i.i.i39
  %.lcssa19 = phi i32 [ %55, %._crit_edge.i.i.i39 ]
  %58 = lshr i32 %tmp10.i.i30, 23
  %59 = and i32 %tmp10.i.i30, -2147483648
  %60 = and i32 %58, 255
  %61 = add i32 %60, -133
  %62 = and i32 %.lcssa19, 8388608
  %63 = icmp eq i32 %62, 0
  %64 = icmp ne i32 %.lcssa19, 0
  %or.cond11.i.i40 = and i1 %63, %64
  br i1 %or.cond11.i.i40, label %udiv32.exit.i.i45.preheader, label %.critedge.i.i52

udiv32.exit.i.i45.preheader:                      ; preds = %udiv32.exit.preheader.i.i41
  br label %udiv32.exit.i.i45

udiv32.exit.i.i45:                                ; preds = %udiv32.exit.i.i45, %udiv32.exit.i.i45.preheader
  %65 = phi i32 [ %indvar.next.i.i44, %udiv32.exit.i.i45 ], [ 0, %udiv32.exit.i.i45.preheader ]
  %temp.012.i.i42 = phi i32 [ %66, %udiv32.exit.i.i45 ], [ %.lcssa19, %udiv32.exit.i.i45.preheader ]
  %66 = shl i32 %temp.012.i.i42, 1
  %67 = and i32 %66, 8388608
  %68 = icmp eq i32 %67, 0
  %69 = icmp ne i32 %66, 0
  %or.cond.i.i43 = and i1 %68, %69
  %indvar.next.i.i44 = add i32 %65, 1
  br i1 %or.cond.i.i43, label %udiv32.exit.i.i45, label %udiv32.exit..critedge_crit_edge.i.i48

udiv32.exit..critedge_crit_edge.i.i48:            ; preds = %udiv32.exit.i.i45
  %.lcssa16 = phi i32 [ %66, %udiv32.exit.i.i45 ]
  %.lcssa15 = phi i32 [ %65, %udiv32.exit.i.i45 ]
  %tmp25.i.i46 = add i32 %60, -134
  %tmp26.i.i47 = sub i32 %tmp25.i.i46, %.lcssa15
  br label %.critedge.i.i52

.critedge.i.i52:                                  ; preds = %udiv32.exit..critedge_crit_edge.i.i48, %udiv32.exit.preheader.i.i41
  %exp.0.lcssa.i.i49 = phi i32 [ %tmp26.i.i47, %udiv32.exit..critedge_crit_edge.i.i48 ], [ %61, %udiv32.exit.preheader.i.i41 ]
  %temp.0.lcssa.i.i50 = phi i32 [ %.lcssa16, %udiv32.exit..critedge_crit_edge.i.i48 ], [ %.lcssa19, %udiv32.exit.preheader.i.i41 ]
  %70 = and i32 %temp.0.lcssa.i.i50, 8388607
  %71 = shl i32 %exp.0.lcssa.i.i49, 23
  %72 = add i32 %71, 1140850688
  %73 = or i32 %70, %59
  %74 = or i32 %73, %72
  %tmp3.i.i51 = bitcast i32 %74 to float
  br label %rotor_flux_calc.exit

rotor_flux_calc.exit:                             ; preds = %.critedge.i.i52, %41
  %75 = phi float [ %tmp3.i.i51, %.critedge.i.i52 ], [ 0.000000e+00, %41 ]
  %76 = fmul float %3, 0x3FE9E83E40000000
  %77 = fmul float %75, 0x3FBA9A7C20000000
  %tmp10.i.i1 = bitcast float %76 to i32
  %tmp6.i.i2 = bitcast float %77 to i32
  %78 = fcmp oeq float %76, 0.000000e+00
  br i1 %78, label %omega_calc.exit, label %79

; <label>:79                                      ; preds = %rotor_flux_calc.exit
  %80 = lshr i32 %tmp10.i.i1, 23
  %81 = and i32 %80, 255
  %82 = lshr i32 %tmp6.i.i2, 23
  %83 = and i32 %82, 255
  %84 = shl i32 %tmp10.i.i1, 7
  %85 = and i32 %84, 1073741696
  %86 = or i32 %85, 1073741824
  %87 = lshr i32 %tmp6.i.i2, 7
  %88 = and i32 %87, 65535
  %89 = or i32 %88, 65536
  %90 = xor i32 %tmp6.i.i2, %tmp10.i.i1
  %91 = and i32 %90, -2147483648
  %92 = sub i32 %81, %83
  switch i32 %89, label %bb.nph7.i.i.i5.preheader [
    i32 0, label %.loopexit.i.i.i13
    i32 1, label %udiv32.exit.preheader.i.i16
  ]

bb.nph7.i.i.i5.preheader:                         ; preds = %79
  br label %bb.nph7.i.i.i5

bb.nph7.i.i.i5:                                   ; preds = %._crit_edge.i.i.i11, %bb.nph7.i.i.i5.preheader
  %.016.i.i.i3 = phi i32 [ %99, %._crit_edge.i.i.i11 ], [ %86, %bb.nph7.i.i.i5.preheader ]
  %quotient.05.i.i.i4 = phi i32 [ %98, %._crit_edge.i.i.i11 ], [ 0, %bb.nph7.i.i.i5.preheader ]
  %93 = lshr i32 %.016.i.i.i3, 1
  %94 = icmp ugt i32 %93, %89
  br i1 %94, label %bb.nph.i.i.i8.preheader, label %._crit_edge.i.i.i11

bb.nph.i.i.i8.preheader:                          ; preds = %bb.nph7.i.i.i5
  br label %bb.nph.i.i.i8

bb.nph.i.i.i8:                                    ; preds = %bb.nph.i.i.i8, %bb.nph.i.i.i8.preheader
  %shifted_divisor.03.i.i.i6 = phi i32 [ %95, %bb.nph.i.i.i8 ], [ %89, %bb.nph.i.i.i8.preheader ]
  %curr_quotient.02.i.i.i7 = phi i32 [ %96, %bb.nph.i.i.i8 ], [ 1, %bb.nph.i.i.i8.preheader ]
  %95 = shl i32 %shifted_divisor.03.i.i.i6, 1
  %96 = shl i32 %curr_quotient.02.i.i.i7, 1
  %97 = icmp ult i32 %95, %93
  br i1 %97, label %bb.nph.i.i.i8, label %._crit_edge.i.i.i11.loopexit

._crit_edge.i.i.i11.loopexit:                     ; preds = %bb.nph.i.i.i8
  %.lcssa13 = phi i32 [ %96, %bb.nph.i.i.i8 ]
  %.lcssa12 = phi i32 [ %95, %bb.nph.i.i.i8 ]
  br label %._crit_edge.i.i.i11

._crit_edge.i.i.i11:                              ; preds = %._crit_edge.i.i.i11.loopexit, %bb.nph7.i.i.i5
  %shifted_divisor.0.lcssa.i.i.i9 = phi i32 [ %89, %bb.nph7.i.i.i5 ], [ %.lcssa12, %._crit_edge.i.i.i11.loopexit ]
  %curr_quotient.0.lcssa.i.i.i10 = phi i32 [ 1, %bb.nph7.i.i.i5 ], [ %.lcssa13, %._crit_edge.i.i.i11.loopexit ]
  %98 = add i32 %curr_quotient.0.lcssa.i.i.i10, %quotient.05.i.i.i4
  %99 = sub i32 %.016.i.i.i3, %shifted_divisor.0.lcssa.i.i.i9
  %100 = icmp ult i32 %99, %89
  br i1 %100, label %.loopexit.i.i.i13.loopexit, label %bb.nph7.i.i.i5

.loopexit.i.i.i13.loopexit:                       ; preds = %._crit_edge.i.i.i11
  %.lcssa14 = phi i32 [ %98, %._crit_edge.i.i.i11 ]
  br label %.loopexit.i.i.i13

.loopexit.i.i.i13:                                ; preds = %.loopexit.i.i.i13.loopexit, %79
  %.0.i.i.i12 = phi i32 [ -1, %79 ], [ %.lcssa14, %.loopexit.i.i.i13.loopexit ]
  br label %udiv32.exit.preheader.i.i16

udiv32.exit.preheader.i.i16:                      ; preds = %.loopexit.i.i.i13, %79
  %temp.0.ph.i.i14 = phi i32 [ %.0.i.i.i12, %.loopexit.i.i.i13 ], [ %86, %79 ]
  %101 = and i32 %temp.0.ph.i.i14, 8388608
  %102 = icmp eq i32 %101, 0
  %103 = icmp ne i32 %temp.0.ph.i.i14, 0
  %or.cond11.i.i15 = and i1 %102, %103
  br i1 %or.cond11.i.i15, label %udiv32.exit.i.i20.preheader, label %.critedge.i.i28

udiv32.exit.i.i20.preheader:                      ; preds = %udiv32.exit.preheader.i.i16
  br label %udiv32.exit.i.i20

udiv32.exit.i.i20:                                ; preds = %udiv32.exit.i.i20, %udiv32.exit.i.i20.preheader
  %104 = phi i32 [ %indvar.next.i.i19, %udiv32.exit.i.i20 ], [ 0, %udiv32.exit.i.i20.preheader ]
  %temp.012.i.i17 = phi i32 [ %105, %udiv32.exit.i.i20 ], [ %temp.0.ph.i.i14, %udiv32.exit.i.i20.preheader ]
  %105 = shl i32 %temp.012.i.i17, 1
  %106 = and i32 %105, 8388608
  %107 = icmp eq i32 %106, 0
  %108 = icmp ne i32 %105, 0
  %or.cond.i.i18 = and i1 %107, %108
  %indvar.next.i.i19 = add i32 %104, 1
  br i1 %or.cond.i.i18, label %udiv32.exit.i.i20, label %udiv32.exit..critedge_crit_edge.i.i24

udiv32.exit..critedge_crit_edge.i.i24:            ; preds = %udiv32.exit.i.i20
  %.lcssa11 = phi i32 [ %105, %udiv32.exit.i.i20 ]
  %.lcssa10 = phi i32 [ %104, %udiv32.exit.i.i20 ]
  %tmp21.i.i21 = add i32 %81, -1
  %tmp25.i.i22 = sub i32 %tmp21.i.i21, %83
  %tmp26.i.i23 = sub i32 %tmp25.i.i22, %.lcssa10
  br label %.critedge.i.i28

.critedge.i.i28:                                  ; preds = %udiv32.exit..critedge_crit_edge.i.i24, %udiv32.exit.preheader.i.i16
  %exp.0.lcssa.i.i25 = phi i32 [ %tmp26.i.i23, %udiv32.exit..critedge_crit_edge.i.i24 ], [ %92, %udiv32.exit.preheader.i.i16 ]
  %temp.0.lcssa.i.i26 = phi i32 [ %.lcssa11, %udiv32.exit..critedge_crit_edge.i.i24 ], [ %temp.0.ph.i.i14, %udiv32.exit.preheader.i.i16 ]
  %109 = and i32 %temp.0.lcssa.i.i26, 8388607
  %110 = shl i32 %exp.0.lcssa.i.i25, 23
  %111 = add i32 %110, 1140850688
  %112 = or i32 %109, %91
  %113 = or i32 %112, %111
  %tmp3.i.i27 = bitcast i32 %113 to float
  %phitmp = fmul float %tmp3.i.i27, 0x4073A28C60000000
  br label %omega_calc.exit

omega_calc.exit:                                  ; preds = %.critedge.i.i28, %rotor_flux_calc.exit
  %114 = phi float [ %phitmp, %.critedge.i.i28 ], [ 0.000000e+00, %rotor_flux_calc.exit ]
  %115 = fadd float %114, %theta_prev.0
  %116 = fcmp olt float %75, 1.000000e+00
  %.op = fmul float %75, 0x40236E2EC0000000
  %tmp10.i.i = bitcast float %torque_ref.0 to i32
  %117 = bitcast float %.op to i32
  %tmp6.i.i = select i1 %116, i32 1092317558, i32 %117
  %118 = fcmp oeq float %torque_ref.0, 0.000000e+00
  br i1 %118, label %iq_err_calc.exit, label %119

; <label>:119                                     ; preds = %omega_calc.exit
  %120 = lshr i32 %tmp10.i.i, 23
  %121 = and i32 %120, 255
  %122 = lshr i32 %tmp6.i.i, 23
  %123 = and i32 %122, 255
  %124 = shl i32 %tmp10.i.i, 7
  %125 = and i32 %124, 1073741696
  %126 = or i32 %125, 1073741824
  %127 = lshr i32 %tmp6.i.i, 7
  %128 = and i32 %127, 65535
  %129 = or i32 %128, 65536
  %130 = xor i32 %tmp6.i.i, %tmp10.i.i
  %131 = and i32 %130, -2147483648
  %132 = sub i32 %121, %123
  switch i32 %129, label %bb.nph7.i.i.i.preheader [
    i32 0, label %.loopexit.i.i.i
    i32 1, label %udiv32.exit.preheader.i.i
  ]

bb.nph7.i.i.i.preheader:                          ; preds = %119
  br label %bb.nph7.i.i.i

bb.nph7.i.i.i:                                    ; preds = %._crit_edge.i.i.i, %bb.nph7.i.i.i.preheader
  %.016.i.i.i = phi i32 [ %139, %._crit_edge.i.i.i ], [ %126, %bb.nph7.i.i.i.preheader ]
  %quotient.05.i.i.i = phi i32 [ %138, %._crit_edge.i.i.i ], [ 0, %bb.nph7.i.i.i.preheader ]
  %133 = lshr i32 %.016.i.i.i, 1
  %134 = icmp ugt i32 %133, %129
  br i1 %134, label %bb.nph.i.i.i.preheader, label %._crit_edge.i.i.i

bb.nph.i.i.i.preheader:                           ; preds = %bb.nph7.i.i.i
  br label %bb.nph.i.i.i

bb.nph.i.i.i:                                     ; preds = %bb.nph.i.i.i, %bb.nph.i.i.i.preheader
  %shifted_divisor.03.i.i.i = phi i32 [ %135, %bb.nph.i.i.i ], [ %129, %bb.nph.i.i.i.preheader ]
  %curr_quotient.02.i.i.i = phi i32 [ %136, %bb.nph.i.i.i ], [ 1, %bb.nph.i.i.i.preheader ]
  %135 = shl i32 %shifted_divisor.03.i.i.i, 1
  %136 = shl i32 %curr_quotient.02.i.i.i, 1
  %137 = icmp ult i32 %135, %133
  br i1 %137, label %bb.nph.i.i.i, label %._crit_edge.i.i.i.loopexit

._crit_edge.i.i.i.loopexit:                       ; preds = %bb.nph.i.i.i
  %.lcssa8 = phi i32 [ %136, %bb.nph.i.i.i ]
  %.lcssa7 = phi i32 [ %135, %bb.nph.i.i.i ]
  br label %._crit_edge.i.i.i

._crit_edge.i.i.i:                                ; preds = %._crit_edge.i.i.i.loopexit, %bb.nph7.i.i.i
  %shifted_divisor.0.lcssa.i.i.i = phi i32 [ %129, %bb.nph7.i.i.i ], [ %.lcssa7, %._crit_edge.i.i.i.loopexit ]
  %curr_quotient.0.lcssa.i.i.i = phi i32 [ 1, %bb.nph7.i.i.i ], [ %.lcssa8, %._crit_edge.i.i.i.loopexit ]
  %138 = add i32 %curr_quotient.0.lcssa.i.i.i, %quotient.05.i.i.i
  %139 = sub i32 %.016.i.i.i, %shifted_divisor.0.lcssa.i.i.i
  %140 = icmp ult i32 %139, %129
  br i1 %140, label %.loopexit.i.i.i.loopexit, label %bb.nph7.i.i.i

.loopexit.i.i.i.loopexit:                         ; preds = %._crit_edge.i.i.i
  %.lcssa9 = phi i32 [ %138, %._crit_edge.i.i.i ]
  br label %.loopexit.i.i.i

.loopexit.i.i.i:                                  ; preds = %.loopexit.i.i.i.loopexit, %119
  %.0.i.i.i = phi i32 [ -1, %119 ], [ %.lcssa9, %.loopexit.i.i.i.loopexit ]
  br label %udiv32.exit.preheader.i.i

udiv32.exit.preheader.i.i:                        ; preds = %.loopexit.i.i.i, %119
  %temp.0.ph.i.i = phi i32 [ %.0.i.i.i, %.loopexit.i.i.i ], [ %126, %119 ]
  %141 = and i32 %temp.0.ph.i.i, 8388608
  %142 = icmp eq i32 %141, 0
  %143 = icmp ne i32 %temp.0.ph.i.i, 0
  %or.cond11.i.i = and i1 %142, %143
  br i1 %or.cond11.i.i, label %udiv32.exit.i.i.preheader, label %.critedge.i.i

udiv32.exit.i.i.preheader:                        ; preds = %udiv32.exit.preheader.i.i
  br label %udiv32.exit.i.i

udiv32.exit.i.i:                                  ; preds = %udiv32.exit.i.i, %udiv32.exit.i.i.preheader
  %144 = phi i32 [ %indvar.next.i.i, %udiv32.exit.i.i ], [ 0, %udiv32.exit.i.i.preheader ]
  %temp.012.i.i = phi i32 [ %145, %udiv32.exit.i.i ], [ %temp.0.ph.i.i, %udiv32.exit.i.i.preheader ]
  %145 = shl i32 %temp.012.i.i, 1
  %146 = and i32 %145, 8388608
  %147 = icmp eq i32 %146, 0
  %148 = icmp ne i32 %145, 0
  %or.cond.i.i = and i1 %147, %148
  %indvar.next.i.i = add i32 %144, 1
  br i1 %or.cond.i.i, label %udiv32.exit.i.i, label %udiv32.exit..critedge_crit_edge.i.i

udiv32.exit..critedge_crit_edge.i.i:              ; preds = %udiv32.exit.i.i
  %.lcssa6 = phi i32 [ %145, %udiv32.exit.i.i ]
  %.lcssa5 = phi i32 [ %144, %udiv32.exit.i.i ]
  %tmp21.i.i = add i32 %121, -1
  %tmp25.i.i = sub i32 %tmp21.i.i, %123
  %tmp26.i.i = sub i32 %tmp25.i.i, %.lcssa5
  br label %.critedge.i.i

.critedge.i.i:                                    ; preds = %udiv32.exit..critedge_crit_edge.i.i, %udiv32.exit.preheader.i.i
  %exp.0.lcssa.i.i = phi i32 [ %tmp26.i.i, %udiv32.exit..critedge_crit_edge.i.i ], [ %132, %udiv32.exit.preheader.i.i ]
  %temp.0.lcssa.i.i = phi i32 [ %.lcssa6, %udiv32.exit..critedge_crit_edge.i.i ], [ %temp.0.ph.i.i, %udiv32.exit.preheader.i.i ]
  %149 = and i32 %temp.0.lcssa.i.i, 8388607
  %150 = shl i32 %exp.0.lcssa.i.i, 23
  %151 = add i32 %150, 1140850688
  %152 = or i32 %149, %131
  %153 = or i32 %152, %151
  %tmp3.i.i = bitcast i32 %153 to float
  br label %iq_err_calc.exit

iq_err_calc.exit:                                 ; preds = %.critedge.i.i, %omega_calc.exit
  %154 = phi float [ %tmp3.i.i, %.critedge.i.i ], [ 0.000000e+00, %omega_calc.exit ]
  %155 = fsub float %flux_ref.0, %75
  %156 = fmul float %155, 0x3E6AD7F2A0000000
  %157 = fadd float %156, %int_flux_err.0
  %158 = fmul float %157, 5.000000e+03
  %159 = fcmp olt float %158, -1.000000e+02
  br i1 %159, label %163, label %160

; <label>:160                                     ; preds = %iq_err_calc.exit
  %161 = fcmp ogt float %158, 1.000000e+02
  br i1 %161, label %163, label %162

; <label>:162                                     ; preds = %160
  br label %163

; <label>:163                                     ; preds = %162, %160, %iq_err_calc.exit
  %int_flux_err.1 = phi float [ %158, %162 ], [ -1.000000e+02, %iq_err_calc.exit ], [ 1.000000e+02, %160 ]
  %164 = fmul float %155, 4.000000e+03
  %165 = fadd float %int_flux_err.1, %164
  %166 = fcmp olt float %165, -2.000000e+02
  br i1 %166, label %.thread, label %167

; <label>:167                                     ; preds = %163
  %168 = fcmp ogt float %165, 2.000000e+02
  br i1 %168, label %.thread, label %169

; <label>:169                                     ; preds = %167
  %170 = fcmp oeq float %165, 0.000000e+00
  br i1 %170, label %fdiv32.exit, label %.thread

.thread:                                          ; preds = %169, %167, %163
  %tmp10.i56.in = phi float [ %165, %169 ], [ -2.000000e+02, %163 ], [ 2.000000e+02, %167 ]
  %tmp10.i56 = bitcast float %tmp10.i56.in to i32
  %171 = shl i32 %tmp10.i56, 7
  %172 = and i32 %171, 1073741696
  %173 = or i32 %172, 1073741824
  br label %bb.nph7.i.i

bb.nph7.i.i:                                      ; preds = %._crit_edge.i.i, %.thread
  %.016.i.i = phi i32 [ %180, %._crit_edge.i.i ], [ %173, %.thread ]
  %quotient.05.i.i = phi i32 [ %179, %._crit_edge.i.i ], [ 0, %.thread ]
  %174 = lshr i32 %.016.i.i, 1
  %175 = icmp ugt i32 %174, 82903
  br i1 %175, label %bb.nph.i.i.preheader, label %._crit_edge.i.i

bb.nph.i.i.preheader:                             ; preds = %bb.nph7.i.i
  br label %bb.nph.i.i

bb.nph.i.i:                                       ; preds = %bb.nph.i.i, %bb.nph.i.i.preheader
  %shifted_divisor.03.i.i = phi i32 [ %176, %bb.nph.i.i ], [ 82903, %bb.nph.i.i.preheader ]
  %curr_quotient.02.i.i = phi i32 [ %177, %bb.nph.i.i ], [ 1, %bb.nph.i.i.preheader ]
  %176 = shl i32 %shifted_divisor.03.i.i, 1
  %177 = shl i32 %curr_quotient.02.i.i, 1
  %178 = icmp ult i32 %176, %174
  br i1 %178, label %bb.nph.i.i, label %._crit_edge.i.i.loopexit

._crit_edge.i.i.loopexit:                         ; preds = %bb.nph.i.i
  %.lcssa3 = phi i32 [ %177, %bb.nph.i.i ]
  %.lcssa2 = phi i32 [ %176, %bb.nph.i.i ]
  br label %._crit_edge.i.i

._crit_edge.i.i:                                  ; preds = %._crit_edge.i.i.loopexit, %bb.nph7.i.i
  %shifted_divisor.0.lcssa.i.i = phi i32 [ 82903, %bb.nph7.i.i ], [ %.lcssa2, %._crit_edge.i.i.loopexit ]
  %curr_quotient.0.lcssa.i.i = phi i32 [ 1, %bb.nph7.i.i ], [ %.lcssa3, %._crit_edge.i.i.loopexit ]
  %179 = add i32 %curr_quotient.0.lcssa.i.i, %quotient.05.i.i
  %180 = sub i32 %.016.i.i, %shifted_divisor.0.lcssa.i.i
  %181 = icmp ult i32 %180, 82903
  br i1 %181, label %udiv32.exit.preheader.i, label %bb.nph7.i.i

udiv32.exit.preheader.i:                          ; preds = %._crit_edge.i.i
  %.lcssa4 = phi i32 [ %179, %._crit_edge.i.i ]
  %182 = lshr i32 %tmp10.i56, 23
  %183 = and i32 %tmp10.i56, -2147483648
  %184 = and i32 %182, 255
  %185 = add i32 %184, -133
  %186 = and i32 %.lcssa4, 8388608
  %187 = icmp eq i32 %186, 0
  %188 = icmp ne i32 %.lcssa4, 0
  %or.cond11.i = and i1 %187, %188
  br i1 %or.cond11.i, label %udiv32.exit.i.preheader, label %.critedge.i

udiv32.exit.i.preheader:                          ; preds = %udiv32.exit.preheader.i
  br label %udiv32.exit.i

udiv32.exit.i:                                    ; preds = %udiv32.exit.i, %udiv32.exit.i.preheader
  %189 = phi i32 [ %indvar.next.i, %udiv32.exit.i ], [ 0, %udiv32.exit.i.preheader ]
  %temp.012.i = phi i32 [ %190, %udiv32.exit.i ], [ %.lcssa4, %udiv32.exit.i.preheader ]
  %190 = shl i32 %temp.012.i, 1
  %191 = and i32 %190, 8388608
  %192 = icmp eq i32 %191, 0
  %193 = icmp ne i32 %190, 0
  %or.cond.i = and i1 %192, %193
  %indvar.next.i = add i32 %189, 1
  br i1 %or.cond.i, label %udiv32.exit.i, label %udiv32.exit..critedge_crit_edge.i

udiv32.exit..critedge_crit_edge.i:                ; preds = %udiv32.exit.i
  %.lcssa1 = phi i32 [ %190, %udiv32.exit.i ]
  %.lcssa = phi i32 [ %189, %udiv32.exit.i ]
  %tmp25.i = add i32 %184, -134
  %tmp26.i = sub i32 %tmp25.i, %.lcssa
  br label %.critedge.i

.critedge.i:                                      ; preds = %udiv32.exit..critedge_crit_edge.i, %udiv32.exit.preheader.i
  %exp.0.lcssa.i = phi i32 [ %tmp26.i, %udiv32.exit..critedge_crit_edge.i ], [ %185, %udiv32.exit.preheader.i ]
  %temp.0.lcssa.i = phi i32 [ %.lcssa1, %udiv32.exit..critedge_crit_edge.i ], [ %.lcssa4, %udiv32.exit.preheader.i ]
  %194 = and i32 %temp.0.lcssa.i, 8388607
  %195 = shl i32 %exp.0.lcssa.i, 23
  %196 = add i32 %195, 1140850688
  %197 = or i32 %196, %183
  %198 = or i32 %197, %194
  %tmp3.i = bitcast i32 %198 to float
  br label %fdiv32.exit

fdiv32.exit:                                      ; preds = %.critedge.i, %169
  %199 = phi float [ %tmp3.i, %.critedge.i ], [ 0.000000e+00, %169 ]
  tail call void @write_float32(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), float %199) nounwind
  tail call void @write_float32(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), float %154) nounwind
  tail call void @write_float32(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), float %115) nounwind
  tail call void @write_float32(i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), float %75) nounwind
  br label %1
}

declare float @read_float32(i8*)

declare void @write_float32(i8*, float)
