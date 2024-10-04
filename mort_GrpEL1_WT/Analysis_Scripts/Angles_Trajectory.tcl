
mol new ../mort_GrpEL1Y173A_final_Sim_QwikMD.psf
mol addfile ../MD3.dcd type dcd first 0 last -1 step 1 waitfor all
#mol addfile ../MD1_2.dcd type dcd first 0 last -1 step 1 waitfor all


# Open the file for writing the angle data
set output_file [open "Y173A_Medial_New_Residue_Test_MD3.dat" "w"]

# Get the number of frames in the trajectory
set num_frames [molinfo top get numframes]


# use frame 0 for the reference
set reference [atomselect top "protein" frame 0]

# the frame being compared
set compare [atomselect top "protein"]

set num_steps [molinfo top get numframes]
for {set frame 0} {$frame < $num_steps} {incr frame} {

    # get the correct frame
    $compare frame $frame

    # compute the transformation
    set trans_mat [measure fit $compare $reference]

    # do the alignment
    $compare move $trans_mat
}


for {set frame 0} {$frame < $num_frames} {incr frame} {
    # Update to the frame we are analyzing
    animate goto $frame

    # Create atom selection objects
    set sel1 [atomselect top "protein and segname AP1 and resid 569 and name CA"]
    set sel2 [atomselect top "protein and segname AP1 and resid 580 and name CA"]
    set sel3 [atomselect top "protein and segname CP1 and resid 200 and name CA"]

    # Measure centers and store in variables
    set center1 [measure center $sel1]
    set center2 [measure center $sel2]
    set center3 [measure center $sel3]

    # Delete the atom selection objects to free memory
    $sel1 delete
    $sel2 delete
    $sel3 delete

    # Define the vectors
    set vec1 [vecsub $center1 $center2]
    set vec2 [vecsub $center1 $center3]

    # Calculate the angle
    set angle_value [angle $vec1 $vec2]

    # Write the angle to the file
    puts $output_file "$frame $angle_value"
}

# Close the output file
close $output_file
