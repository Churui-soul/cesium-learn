uniform float uTime;

//https://iquilezles.org/articles/palettes/
vec3 palette( float t ) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263,0.416,0.557);

    return a + b*cos( 6.28318*(c*t+d) );
}


czm_material czm_getMaterial(czm_materialInput position) {
    czm_material material = czm_getDefaultMaterial(position);

    vec2 uv = vec2(position.st.s - .5, position.st.t - .5);
    vec3 finalColor = vec3(0.0);
    
    // Speed of sweeps. The inner sweep will probably look shit if you don't adjust the values below
    float innerSweepSpeed = 4.;
    float outerSweepSpeed = .62;
   
    // Background sweep
    finalColor.y = palette(uv.x * 0.1 - uTime * outerSweepSpeed + .25).y * 0.2;
    
    if (length(uv) <= 1.1) {
       
        // Outer circle
        if (length(uv) >= 1.04) {
            finalColor.y += palette(length(uv) * 15. + .53).y;
        }
        
        if (length(uv) <= 1.06) {
            // Vertical line
            if (uv.x < .015 && uv.x > -.015) {
            finalColor.y += palette(uv.x * 30. + .6).y * .8;
            }
            // Horizonal line
            if (uv.y < .015 && uv.y > -.015) {
                finalColor.y += palette(uv.y * 30. + .6).y * .8;
            }
            // Smaller inside circles
            float temp = palette(length(uv) * 4.5 + .53).y;
            finalColor.y += .2 + pow(temp, 100.) * .6;
            
            // Circular sweep. Don't recommend trying to change this, it's a pain.
            vec2 d = vec2(sin(innerSweepSpeed * uTime), cos(innerSweepSpeed * uTime)) * length(uv);
            vec2 d2 = vec2(sin(innerSweepSpeed * (uTime - 0.4)), cos(innerSweepSpeed * (uTime - 0.4))) * length(uv);
            float val = length(d - uv) / length(uv);
            float val2 = length(d2 - uv) / length(uv);
            if (1./val > .45 && val2 > 1.8) {
                finalColor.y += palette(log(val * 0.4 + 0.83)).y;
            }
        }
    }

    material.diffuse = finalColor;
    material.alpha = dot(finalColor, finalColor);

    return material;
}