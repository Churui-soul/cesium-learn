import * as Cesium from 'cesium'
import radarScanShader from './shader/radar_scan.glsl'
import radarDiffuseShader from './shader/radar_diffuse.glsl'

// 扩散
export class RaderDiffuseMaterial {
    constructor () {
        (Cesium.Material as any)._materialCache.addMaterial('RaderDiffuseMaterial', {
            fabric: {
                type: 'RaderDiffuseMaterial',
                uniforms: {
                    uTime: 0
                },
                source: radarDiffuseShader
            }
        })
    }
    getType() {
        return 'RaderDiffuseMaterial'
    }
    getValue(_time: number, result: any) {
        result.uTime = performance.now() / 1000
        return result
    } 
}

// 扫描
export class RaderScanMaterial {
    constructor () {
        (Cesium.Material as any)._materialCache.addMaterial('RaderScanMaterial', {
            fabric: {
                type: 'RaderScanMaterial',
                uniforms: {
                    uTime: 0
                },
                source: radarScanShader
            }
        })
    }
    getType() {
        return 'RaderScanMaterial'
    }
    getValue(_time: number, result: any) {
        result.uTime = performance.now() / 1000
        return result
    } 
}
