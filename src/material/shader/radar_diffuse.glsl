uniform float uTime;


vec3 RadarPing(vec2 uv, vec2 center, float innerTail, float frontierBorder, float timeResetSeconds, float radarPingSpeed, float fadeDistance, float t)
{
    vec2 diff = center - uv;
    float r = length(diff);
    float time = mod(t, timeResetSeconds) * radarPingSpeed;

    float circle;
    circle += smoothstep(time - innerTail, time, r) * smoothstep(time + frontierBorder,time, r);
    circle *= smoothstep(fadeDistance, -.3, r); // fade to 0 after fadeDistance
        
    return vec3(circle);
}

czm_material czm_getMaterial(czm_materialInput position) 
{
    czm_material material = czm_getDefaultMaterial(position);
    vec2 uv = position.st;
    
    vec3 color;
    // // generate some radar pings
    float fadeDistance = 0.8;
    float resetTimeSec = 2.0;
    float radarPingSpeed = 0.2;
    vec2 greenPing = vec2(0.5, 0.5);

    color += RadarPing(uv, greenPing, 0.25, 0.025, resetTimeSec, radarPingSpeed, fadeDistance, uTime) * vec3(0.0,0.5,0.7);
    color += RadarPing(uv, greenPing, 0.25, 0.025, resetTimeSec, radarPingSpeed, fadeDistance, uTime + 1.0) * vec3(0.0,0.5,0.7);
    color += RadarPing(uv, greenPing, 0.25, 0.025, resetTimeSec, radarPingSpeed, fadeDistance, uTime + .5) * vec3(0.0,0.5,0.7);

    material.diffuse = color;
    material.alpha = dot(color, color);

    return material;
}