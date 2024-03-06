uniform float uTime;
uniform vec3 iResolution;

#define green vec3(0.0,1.0,0.0)

vec3 RadarPing(vec2 uv, vec2 center, float innerTail, float frontierBorder, float timeResetSeconds, float radarPingSpeed, float fadeDistance)
{
    vec2 diff = center - uv;
    float r = length(diff);
    float time = mod(uTime, timeResetSeconds) * radarPingSpeed;

    float circle;
    circle += smoothstep(time - innerTail, time, r) * smoothstep(time + frontierBorder,time, r);
    circle *= smoothstep(fadeDistance, 0.0, r); // fade to 0 after fadeDistance
        
    return vec3(circle);
}

czm_material czm_getMaterial(czm_materialInput position) 
{
    czm_material material = czm_getDefaultMaterial(position);
    vec2 uv = position.st;
    uv.st *= 2.0;
    uv.st += vec2(-1.0, -1.0);
    uv.st += vec2(-1.0, -1.0);
    uv.x *= 40.0/40.0;
    // vec2 uv = vec2(position.st.s / 40.0, position.st.t / 40.0);
    // uv = uv.xy*2.0;
    // uv += vec2(-1.0, -1.0);
    // uv.x *= 40.0/40.0;
    
    vec3 color;
    // // generate some radar pings
    float fadeDistance = 1.0;
    float resetTimeSec = 4.0;
    float radarPingSpeed = 0.3;
    vec2 greenPing = vec2(0.0, 0.0);
    color += RadarPing(uv, greenPing, 0.25, 0.025, resetTimeSec, radarPingSpeed, fadeDistance) * green;
    
    material.diffuse = color;
    material.alpha = 1.0; 

    return material;
}