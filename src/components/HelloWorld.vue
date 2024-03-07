<script setup lang="ts">
import { ref, onMounted } from 'vue'

import * as Cesium from 'cesium'
// import { ScreenSpaceEventHandler, UniformType } from 'cesium'
import 'cesium/Build/CesiumUnminified/Widgets/widgets.css'

import { RaderDiffuseMaterial, RaderScanMaterial } from '../material/rader'

const cesiumContainer = ref(null)

// // 添加行政区
// const addGeojson = (viewer: Cesium.Viewer) => {
//     Cesium.GeoJsonDataSource.load('/geojson/beijing.json', {
//         fill: Cesium.Color.fromCssColorString('#03040e'),
//         stroke: Cesium.Color.fromCssColorString('#fab536'),
//         strokeWidth: 2,
//     }).then(datasource => {
//         viewer.dataSources.add(datasource)
//         viewer.flyTo(datasource)

//         // 删除
//         // viewer.dataSources.remove(datasource)
//     })
// }
// // 添加点示例，这不是方法
// const addPoint = (viewer: Cesium.Viewer) => {
//     const point = viewer.entities.add({
//         properties: {},
//         position: Cesium.Cartesian3.fromDegrees(0, 0, 0),
//         label: {
//             show: true,
//             text: 'go right',
//             font: '20px sans-serif',
//             pixelOffset: new Cesium.Cartesian2(0, 50), // 文字偏移
//             fillColor: Cesium.Color.WHITE,
//             distanceDisplayCondition: new Cesium.DistanceDisplayCondition(0, 1500) // 达到一定高度隐藏
//         },
//         billboard: {
//             show: true,
//             scale: 1.0,
//             image: 'goright.png',
//             sizeInMeters: false,
//             verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
//             horizontalOrigin: Cesium.HorizontalOrigin.LEFT,
//             pixelOffset: new Cesium.Cartesian2(-25, 10)
//         }
//     })

//     // 删除
//     // viewer.entities.remove(point)
// }
// // 海量点示例
// const addMassPoint = (viewer: Cesium.Viewer) => {
//     // 创建一个海量点的实体集合
//     const billboardsCollection = viewer.scene.primitives.add(new Cesium.BillboardCollection())

//     // 循环添加点实体到实体集合中
//     for (var i = 0; i < 50000; i++) {
//         var position = Cesium.Cartesian3.fromDegrees(Math.random() * 180 - 90, Math.random() * 360 - 180, 10000); // 生成随机经纬度和高度
//         billboardsCollection.add({
//             position: position, // 设置点的位置
//             image: 'goright.png', // 设置图标的图片URL
//             width: 20, // 设置图标的宽度
//             height: 20, // 设置图标的高度
//         })
//     }

//     // viewer.scene.primitives.remove(billboardsCollection)
// }
// // 添加线条示例
// const addPolyline = (viewer: Cesium.Viewer) => {
//     const redLine = viewer.entities.add({
//         name: "Red line on terrain",
//         polyline: {
//             positions: Cesium.Cartesian3.fromDegreesArray([-75, 35, -125, 35]),
//             width: 5,
//             material: Cesium.Color.RED,
//             clampToGround: true,
//         },
//     });

//     const greenRhumbLine = viewer.entities.add({
//         name: "Green rhumb line",
//         polyline: {
//             positions: Cesium.Cartesian3.fromDegreesArray([-75, 35, -125, 35]),
//             width: 5,
//             arcType: Cesium.ArcType.RHUMB,
//             material: Cesium.Color.GREEN,
//         },
//     });

//     const glowingLine = viewer.entities.add({
//         name: "Glowing blue line on the surface",
//         polyline: {
//             positions: Cesium.Cartesian3.fromDegreesArray([-75, 37, -125, 37]),
//             width: 10,
//             material: new Cesium.PolylineGlowMaterialProperty({
//             glowPower: 0.2,
//             taperPower: 0.5,
//             color: Cesium.Color.CORNFLOWERBLUE,
//             }),
//         },
//     });

//     const orangeOutlined = viewer.entities.add({
//         name:
//             "Orange line with black outline at height and following the surface",
//         polyline: {
//             positions: Cesium.Cartesian3.fromDegreesArrayHeights([
//             -75,
//             39,
//             250000,
//             -125,
//             39,
//             250000,
//             ]),
//             width: 5,
//             material: new Cesium.PolylineOutlineMaterialProperty({
//             color: Cesium.Color.ORANGE,
//             outlineWidth: 2,
//             outlineColor: Cesium.Color.BLACK,
//             }),
//         },
//     });

//     const purpleArrow = viewer.entities.add({
//         name: "Purple straight arrow at height",
//         polyline: {
//             positions: Cesium.Cartesian3.fromDegreesArrayHeights([
//             -75,
//             43,
//             500000,
//             -125,
//             43,
//             500000,
//             ]),
//             width: 10,
//             arcType: Cesium.ArcType.NONE,
//             material: new Cesium.PolylineArrowMaterialProperty(
//             Cesium.Color.PURPLE
//             ),
//         },
//     });

//     const dashedLine = viewer.entities.add({
//         name: "Blue dashed line",
//         polyline: {
//             positions: Cesium.Cartesian3.fromDegreesArrayHeights([
//             -75,
//             45,
//             500000,
//             -125,
//             45,
//             500000,
//             ]),
//             width: 4,
//             material: new Cesium.PolylineDashMaterialProperty({
//             color: Cesium.Color.CYAN,
//             }),
//         },
//     });
// }
// // 绑定事件
// const bindClick = (viewer: Cesium.Viewer) => {
//     let handler = new Cesium.ScreenSpaceEventHandler(viewer.scene.canvas)
//     handler.setInputAction((event: ScreenSpaceEventHandler.PositionedEvent) => {
//         var pickedFeature = viewer.scene.pick(event.position)
//         // 判断是否拾取到目标
//         if (Cesium.defined(pickedFeature)) {
//             console.log(pickedFeature)
//         }
//     }, Cesium.ScreenSpaceEventType.LEFT_CLICK)
// }
// 雷达
const radar = (viewer: Cesium.Viewer) => {
    viewer.entities.add({
        position: Cesium.Cartesian3.fromDegrees(90.0, 40.0),
        name: "Red ellipse on surface",
        ellipse: {
            semiMinorAxis: 250000.0,
            semiMajorAxis: 250000.0,
            material: new RaderScanMaterial() as unknown as Cesium.MaterialProperty,
        },
    })
    viewer.flyTo(viewer.entities)
}

onMounted(async () => {
    const viewer = new Cesium.Viewer(cesiumContainer.value as unknown as Element, {
        shouldAnimate: false,
        infoBox: false,
        fullscreenButton:false,
        showRenderLoopErrors: false,
        selectionIndicator: false, // 显示实体对象选择框，默认true
        // 顶部按钮
        geocoder: false,
        homeButton: false,
        sceneModePicker: false,
        navigationHelpButton: false,
        baseLayerPicker: false,
        // 底部按钮
        timeline: false,
        animation: false,

        // 默认地形
        // terrain: Cesium.Terrain.fromWorldTerrain(),
    })

    // var thirdPartyTileUrl = '/map/tiles/{z}/{x}/{y}/tile.png'; // 替换为实际的第三方瓦片URL
    // var imageryProvider = new Cesium.UrlTemplateImageryProvider({
    //     url: thirdPartyTileUrl,
    //     maximumLevel: 10, // 根据实际瓦片层级设置
    //     minimumLevel: 0, // 根据实际瓦片层级设置
    // })

    // viewer.imageryLayers.addImageryProvider(imageryProvider)

    // 关闭默认瓦片
    // viewer.imageryLayers.get(0).show = false
    // 根据太阳位置开启照明
    // viewer.scene.globe.enableLighting = true;
    // 启用深度测试，以便地形后面的东西消失。
    // viewer.scene.globe.depthTestAgainstTerrain = false;

    // 瓦片数据
    // const wmtsImageryProvider = new Cesium.WebMapTileServiceImageryProvider({
    //     url: 'http://t0.tianditu.com/img_w/wmts?service=wmts&request=GetTile&version=1.0.0&LAYER=img&tileMatrixSet=w&TileMatrix={TileMatrix}&TileRow={TileRow}&TileCol={TileCol}&style=default&format=tiles&tk=9bcd9528d53d1c06caac85daf1012ecd',
    //     layer : 'img',
    //     style : '',
    //     format : 'image/jpeg',
    //     tileMatrixSetID : 'GoogleMapsCompatible',
    // });
    // viewer.imageryLayers.addImageryProvider(wmtsImageryProvider)

    // 地形数据
    // viewer.terrainProvider = await Cesium.CesiumTerrainProvider.fromUrl('url', {
    //     requestVertexNormals: true,
    // })
    
    radar(viewer)
})

// function guid() {
//     function S4() {
//         return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
//     }
//     return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4())
// }
</script>

<template>
    <div ref="cesiumContainer" id="cesiumContainer"></div>
</template>

<style scoped lang="less">
#cesiumContainer {
    width: 100vw;
    height: 100vh;

    :deep(.cesium-widget-credits) {
        display: none;
    }
}
</style>
