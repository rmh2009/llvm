# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=btver2 < %s | FileCheck %s --check-prefixes=CHECK,BTVER2

pcmpestri   $1, %xmm0, %xmm2
pcmpestri   $1, (%rax), %xmm2

pcmpestrm   $1, %xmm0, %xmm2
pcmpestrm   $1, (%rax), %xmm2

pcmpistri   $1, %xmm0, %xmm2
pcmpistri   $1, (%rax), %xmm2

pcmpistrm   $1, %xmm0, %xmm2
pcmpistrm   $1, (%rax), %xmm2

pcmpgtq     %xmm0, %xmm2
pcmpgtq     (%rax), %xmm2

# CHECK:      Resources:
# CHECK-NEXT: [0] - JALU0
# CHECK-NEXT: [1] - JALU1
# CHECK-NEXT: [2] - JDiv
# CHECK-NEXT: [3] - JFPA
# CHECK-NEXT: [4] - JFPM
# CHECK-NEXT: [5] - JFPU0
# CHECK-NEXT: [6] - JFPU1
# CHECK-NEXT: [7] - JLAGU
# CHECK-NEXT: [8] - JMul
# CHECK-NEXT: [9] - JSAGU
# CHECK-NEXT: [10] - JSTC
# CHECK-NEXT: [11] - JVALU0
# CHECK-NEXT: [12] - JVALU1
# CHECK-NEXT: [13] - JVIMUL

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   	Instructions:
# CHECK-NEXT:  -      -      -      -      -     5.00   10.00  5.00    -      -      -      -      -      -     	pcmpestri	$1, %xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -     5.00   10.00  6.00    -      -      -      -      -      -     	pcmpestri	$1, (%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -     5.00   10.00  5.00    -      -      -      -      -      -     	pcmpestrm	$1, %xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -     5.00   10.00  6.00    -      -      -      -      -      -     	pcmpestrm	$1, (%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -     2.00   2.00    -      -      -      -      -      -      -     	pcmpistri	$1, %xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -     2.00   2.00   1.00    -      -      -      -      -      -     	pcmpistri	$1, (%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -     2.00   2.00    -      -      -      -      -      -      -     	pcmpistrm	$1, %xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -     2.00   2.00   1.00    -      -      -      -      -      -     	pcmpistrm	$1, (%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -     1.00    -      -      -      -      -     1.00    -     	pcmpgtq	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -     1.00    -     1.00    -      -      -     1.00    -      -     	pcmpgtq	(%rax), %xmm2
