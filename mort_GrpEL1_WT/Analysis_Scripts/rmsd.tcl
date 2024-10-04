
# This is a script to calculate the RMSD for all frames of a molecule
# Usage: rmsd <molecule id> <seltext>

proc write_vector { vec name } {
  set fid [open $name w]
  foreach elem $vec { puts $fid $elem }
  close $fid
}

proc rmsd { molid seltext outputFilename } {
  set outfile [open $outputFilename w]
  set ref [atomselect $molid $seltext frame 0]
  set sel [atomselect $molid $seltext]
  set n [molinfo $molid get numframes]

  for { set i 1 } { $i < $n } { incr i } {
    $sel frame $i
    lappend rms [ measure rmsd $sel $ref ]
  }
  
  puts $outfile $rms
  $ref delete
  $sel delete
  return $rms
}

  
# This is a script to align animation frames based on a selection.  You'll
# probably want to run this before calculating rmsd

proc align { molid seltext } {
  set ref [atomselect $molid $seltext frame 0]
  set sel [atomselect $molid $seltext]
  set all [atomselect $molid all]
  set n [molinfo $molid get numframes]

  for { set i 1 } { $i < $n } { incr i } {
    $sel frame $i   
    $all frame $i
    $all move [measure fit $sel $ref]
  }
  return
}
    
proc centeralign { molid seltext } {
  set sel [atomselect $molid $seltext]
  set all [atomselect $molid all]
  $sel frame 0
  set center [measure center $sel]
  set n [molinfo $molid get numframes]

  for { set i 1 } { $i < $n } { incr i } {
    $sel frame $i   
    $all frame $i
    $all moveby [vecsub $center [measure center $sel]]
  }
  return
}
    
