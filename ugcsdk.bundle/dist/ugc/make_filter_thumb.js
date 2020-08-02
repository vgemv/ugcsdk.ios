let fs = require("fs");
let child_process = require("child_process");
let path = require("path");

let root =
    "/Users/weijh/project/video_sdk/video_editor_sdk/webui/public/ugc/filter/";
let ffmpeg = "/Users/weijh/project/video_sdk/TEST/ffmpeg_build/ffmpeg_g";
let cmd = `${ffmpeg} -f ugc -i movie=/Users/weijh/Downloads/87d538b0d12c37dd3c7655d1a06f80cf.jpg,scale=300:-1,setsar=1:1,setdar=3:2,crop=200:200:0:0,format=rgba,hwupload,glfilter=source={source}:percent=100{lutpng},hwdownload,format=rgba -y {thumb}`;

let list = require(root + "list.json");

list = list.flatMap((i) => {
    return i.list || [i];
});
console.log(list);
list = list.map((i) => {
    let lutpng = "";
    if (i.source_list) {
        lutpng = `:lutpng=\'${i.source_list.join("|")}\'`;
    }
    return cmd
        .replace("{source}", i.source)
        .replace("{thumb}", i.thumb)
        .replace("{lutpng}", lutpng);
});
console.log(list);
// child_process.exec(list[7], {cwd:root}, (error,stdout,stderr)=>{
//     console.log(error)
//     console.log(stderr)
// });
list.forEach(i=>{
    child_process.exec(i, {cwd:root});
})
// console.log(list)
