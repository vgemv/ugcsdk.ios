cordova.define("cordova-plugin-ugc-app.UGCApp", function(require, exports, module) {

var exec = require('cordova/exec');


var UGCApp = {
    StatusCode: {
        Ok: 1, Cancel: 0, Fail: -1
    },

    getConfig:function(success, error) {
        exec(success, error, "UGCApp", "getConfig", []);
    },
    done:function(opt, success, error) {
        exec(success, error, "UGCApp", "done", [opt]);
    },
    scanFile:function(path, success, error) {
        exec(success, error, "UGCApp", "scan_file", [path]);
    },
    sendToDCIM:function(path, success, error) {
        exec(success, error, "UGCApp", "sendToDCIM", [path]);
    },
    MediaPicker:{
        getMedias:function(opt, success, error) {
            exec(success, error, "UGCApp", "getMedias", [opt]);
        }
    },
    webserver:{
        start:function( success, error) {
            exec(success, error, "UGCApp", "webserver_start", []);
        },
        stop:function( success, error) {
            exec(success, error, "UGCApp", "webserver_stop", []);
        }
    },
    ffplay:{
        play:function(cmd, success, error) {
            exec(success, error, "UGCApp", "ffplay@play", [cmd]);
        },
        setEventCallback(success, error) {
            exec(success, error, "UGCApp", "ffplay@setEventCallback", []);
        },
        stop:function(success, error){
            exec(success, error, "UGCApp", "ffplay@stop", []);
        },
        resume:function(success, error){
            exec(success, error, "UGCApp", "ffplay@resume", []);
        },
        pause:function(success, error){
            exec(success, error, "UGCApp", "ffplay@pause", []);
        },
        seek:function(seek, success, error){
            exec(success, error, "UGCApp", "ffplay@seek", [seek]);
        },
        position:function(success, error){
            exec(success, error, "UGCApp", "ffplay@position", []);
        },
        duration:function(success, error){
            exec(success, error, "UGCApp", "ffplay@duration", []);
        },
        running:function(success, error){
            exec(success, error, "UGCApp", "ffplay@running", []);
        },
        refresh:function(success, error){
            exec(success, error, "UGCApp", "ffplay@refresh", []);
        },
        mute:function(ismute, success, error){
            exec(success, error, "UGCApp", "ffplay@mute", [ismute]);
        },
        command:function(cmd, arg, success, error){
            if(arg !== undefined)
            exec(success, error, "UGCApp", "ffplay@command", [cmd, arg]);
        },
        thumb:function(des, success, error){
            exec(success, error, "UGCApp", "ffplay@thumb", [des]);
        },
        rect:function(left, top, width, height, success, error){
            exec(success, error, "UGCApp", "ffplay@rect", [left, top, width, height]);
        }
    },
    ffmpeg:{
        start:function(cmd, success, error) {
            exec(success, error, "UGCApp", "start", [cmd]);
        },
        cancel:function( success, error) {
            exec(success, error, "UGCApp", "cancel", []);
        },
        progress:function( success, error) {
            exec(success, error, "UGCApp", "progress", []);
        },
        format:function(path, success, error) {
            exec(success, error, "UGCApp", "format", [path]);
        },
        status:function( success, error) {
            exec(success, error, "UGCApp", "status", []);
        },
        report:function( success, error) {
            exec(success, error, "UGCApp", "report", []);
        },
        thumb:function( src, des, ss, duration, span, success, error) {
            exec(success, error, "UGCApp", "thumb", [src, des, ss, duration, span]);
        }
    }
};

module.exports = UGCApp;

});
