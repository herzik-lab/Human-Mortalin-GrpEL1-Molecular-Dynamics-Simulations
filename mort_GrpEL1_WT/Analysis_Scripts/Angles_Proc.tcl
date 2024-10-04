proc angle {vec1 vec2} {
    # Calculate the magnitude of the vectors
    set mag_vec1 [veclength $vec1]
    set mag_vec2 [veclength $vec2]

    # Calculate the dot product
    set dot_prod [vecdot $vec1 $vec2]

    # Calculate the angle in radians and then convert to degrees
    set angle_deg [expr {acos($dot_prod / ($mag_vec1 * $mag_vec2)) * (180 / 3.141592653589793)}]

    # Return the angle in degrees
    return $angle_deg
}
