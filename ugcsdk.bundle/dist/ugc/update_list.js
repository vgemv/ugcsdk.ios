let fs = require("fs");
let child_process = require("child_process");
let path = require("path");

var root =
    "/Users/weijh/project/video_sdk/video_editor_sdk/webui/public/ugc/audio/";

update(root);
function update(root) {
    //获取此文件夹下所有的文件(数组)
    var files = fs.readdirSync(root);

    var json = [];

    //遍历这些文件或者文件夹
    for (let i = 0; i < files.length; i++) {
        //为文件创建一个描述对象
        var folder = {};
        //添加name属性
        folder.name = files[i];
        var fileStat = fs.statSync(path.join(root, files[i]));
        //判断是否是文件夹
        if (fileStat.isDirectory()) {
            //文件夹类型则添加type属性为dir

            json.push(folder);
            folder.list = [];

            var allFiles = fs.readdirSync(path.join(root, files[i]));

            for (let i = 0; i < allFiles.length; i++) {
                let file = {};
                file.name = child_process
                    .execSync("basename " + allFiles[i])
                    .toString()
                    .replace(".mp3", "")
                    .replace("\n", "");
                file.source = path.join(folder.name, allFiles[i]);
                file.duration = child_process
                    .execSync(
                        "ffmpeg -i '" +
                            path.join(root, file.source) +
                            "' -f null -y /dev/null 2>&1|grep speed|awk '{print $2}'|cut -d':' -f 3"
                    )
                    .toString()
                    .replace("\n", "");
                folder.list.push(file);
            }
        } else {
            //文件类型则添加type属性为文件后缀名
        }
    }

    fs.writeFileSync(
        path.join(root, "list.json"),
        JSON.stringify(json, null, "\t")
    );
}
