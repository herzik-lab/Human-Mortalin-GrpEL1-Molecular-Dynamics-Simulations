source rmsd.tcl

mol new ../mort_GrpEL1Y173A_final_Sim_QwikMD.psf
mol addfile ../MD2.dcd type dcd first 0 last -1 step 1 waitfor all
#mol addfile ../MD1_2.dcd type dcd first 0 last -1 step 1 waitfor all

align 0 "backbone"

# Generate filenames dynamically
set prefix "rmsd_result"
set output1 "Y173A_GrpEL-B_Rep2.txt"
set output2 "Y173A_SBD_Domain_Rep2.txt"
set output3 "Y173A_SBD_Lid_Rep2.txt"
set output4 "Y173A_SBD_Domain_SBD_Lid_Rep2.txt"

# Calculate RMSD for different selections and output to dynamically generated files
rmsd 0 "chain C and resid 160 to 217 and name N O C CA" $output1
rmsd 0 "chain A and resid 440 to 555 and name N O C CA" $output2
rmsd 0 "chain A and resid 556 to 639 and name N O C CA" $output3
rmsd 0 "chain A and resid 440 to 639 and name N O C CA" $output4
