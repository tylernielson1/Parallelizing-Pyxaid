!! OpenMP thread-safe C, C++, f90 timing routines
!! Dave Turner - Kansas State University - September of 2015
!! This is free code distributed under the GPL license

!! f90 stubs to call C timer functions
!! f90  Compile in the mytimer_f90.90 module and this mytimer.c file using OpenMP
!!        for gcc compile mytimer.c with -fopenmp
!!        for icc compile mytimer.c with -openmp
!!      USE mytimer_f90              in all sections where the timer is used
!!      Timer_Start( "blockname" );  starts the timer for 'blockname'
!!      Timer_Stop( );               stops the timer for the current block
!!      Timer_Report( "time.out" );  dumps the time info to file 'time.out'
!!      Timer_Log_Flops( nflops );   logs nflops floating ops to current block
!!      Timer_Log_Bytes( nbytes );   logs nbytes bytes communicated within block
!!         nflops and nbytes should be 64-bit integers


MODULE mytimer_f90

   INTERFACE
      SUBROUTINE TimerStart( blockname ) bind (C, name="TimerStart" )
         USE iso_c_binding, only : C_CHAR
         CHARACTER( kind=C_CHAR ) :: blockname(*)
      END SUBROUTINE TimerStart
   END INTERFACE

   INTERFACE
      SUBROUTINE TimerStop( ) bind (C, name="TimerStop" )
      END SUBROUTINE TimerStop
   END INTERFACE

   INTERFACE
      SUBROUTINE TimerReport( timefile ) bind (C, name="TimerReport" )
         USE iso_c_binding, only : C_CHAR
         CHARACTER( kind=C_CHAR ) :: timefile(*)
      END SUBROUTINE TimerReport
   END INTERFACE

   INTERFACE
      SUBROUTINE TimerLogFlops( nflops ) bind (C, name="TimerLogFlops" )
         USE iso_c_binding, only : C_INT64_T
         INTEGER( kind=C_INT64_T ) :: nflops
      END SUBROUTINE TimerLogFlops
   END INTERFACE

   INTERFACE
      SUBROUTINE TimerLogBytes( nbytes ) bind (C, name="TimerLogBytes" )
         USE iso_c_binding, only : C_INT64_T
         INTEGER( kind=C_INT64_T ) :: nbytes
      END SUBROUTINE TimerLogBytes
   END INTERFACE

CONTAINS

SUBROUTINE Timer_Start( blockname )
   USE iso_c_binding, only : C_CHAR, C_NULL_CHAR
   CHARACTER( LEN=* ) :: blockname
   CALL TimerStart( blockname // C_NULL_CHAR )
END SUBROUTINE Timer_Start


SUBROUTINE Timer_Stop( )
   CALL TimerStop( )
END SUBROUTINE Timer_Stop


SUBROUTINE Timer_Report( timefile )
   USE iso_c_binding, only : C_CHAR, C_NULL_CHAR
   CHARACTER( LEN=* ) :: timefile
   CALL TimerReport( timefile // C_NULL_CHAR )
END SUBROUTINE Timer_Report


SUBROUTINE Timer_Log_Flops( nflops )
   USE iso_c_binding, only : C_INT64_T
   INTEGER( kind=C_INT64_T ) :: nflops
   CALL TimerLogFlops( nflops )
END SUBROUTINE Timer_Log_Flops

SUBROUTINE Timer_Log_Bytes( nbytes )
   USE iso_c_binding, only : C_INT64_T
   INTEGER( kind=C_INT64_T ) :: nbytes
   CALL TimerLogBytes( nbytes )
END SUBROUTINE Timer_Log_Bytes


END MODULE mytimer_f90

