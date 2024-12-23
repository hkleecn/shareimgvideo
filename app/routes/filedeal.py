from flask import Flask, render_template, request, redirect, url_for, flash
from werkzeug.utils import secure_filename
import os
​from loguru import logger
from ..base import base
from ..models import User, Organization, Role,Dealfile
from flask import jsonify

UPLOAD_FOLDER = 'uploads'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
ALLOWED_VIDEO_EXTENSIONS = {'mp4', 'avi', 'flv', 'wmv', 'webm'}

def allowed_imagefile(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

​def allowed_videofile(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_VIDEO_EXTENSIONS
​
@base.route('/index')
def index():
    return render_template('index.html')
​
@base.route('/base/upload-imagefile', methods=['POST'])
def upload_imagefile():
    if 'file' not in request.files:
        flash('No file part')
        return redirect(request.url)
    file = request.files['file']
    if file.filename == '':
        flash('No image selected for uploading')
        return redirect(request.url)
    if file and allowed_imagefile(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        flash('Image successfully uploaded and displayed below')
        #更新数据库记录
        dealfile = Dealfile(FILENAME=filename, USER_ID=id)  
        dealfile.s3_upload(filename)
        db.session.add(dealfile)
        db.session.commit()
        return jsonify({'success': True, 'filename':filename})
    else:
        flash('Allowed image types are - png, jpg, jpeg, gif')
        return jsonify({'success': False, 'msg': 'upload failed！'})
    

@base.route('/base/upload-videofile', methods=['POST'])
def upload_videofile():
    id = request.form.get('data.id')
    loginname = request.form.get('data.loginname')
    
    if User.query.filter(User.LOGINNAME == loginname).filter(User.ID != id).first():
        return jsonify({'success': False, 'msg': '更新用户失败，用户名已存在！'})
    
    if 'file' not in request.files:
        flash('No file part')
        return redirect(request.url)
    file = request.files['file']
    if file.filename == '':
        flash('No video selected for uploading')
        return redirect(request.url)
    if file and allowed_videofile(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        flash('video successfully uploaded and displayed below')
        dealfile = Dealfile(FILENAME=filename, USER_ID=id)
        dealfile.s3_upload(filename)
        #更新数据库记录
        db.session.add(dealfile)
        db.session.commit()
        return jsonify({'success': True, 'filename':filename})
    else:
        flash('Allowed video types are - mp4 avi flv wmv webm')
        return jsonify({'success': False, 'msg': 'upload failed！'})

@base.route('/base/delet-videofile', methods=['POST'])
def delete_videofile(filename):
    try:
        id = request.form.get('data.id')
        loginname = request.form.get('data.loginname')
        
        if User.query.filter(User.LOGINNAME == loginname).filter(User.ID != id).first():
            return jsonify({'success': False, 'msg': '更新用户失败，用户名已存在！'})
    
            os.remove(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            dealfile = Dealfile(FILENAME=filename, USER_ID=id)
            dealfile.s3_delete(filename)
            #删除数据库记录
            db.session.delete(dealfile)
            db.session.commit()
            return jsonify({'success': True, 'filename':filename})
    except:
        return jsonify({'success': False, 'msg': '删除文件失败！'})

@base.route('/base/delet-imagefile', methods=['POST'])
def delete_imagefile(filename):
    try:
        id = request.form.get('data.id')
        loginname = request.form.get('data.loginname')
        
        if User.query.filter(User.LOGINNAME == loginname).filter(User.ID != id).first():
            return jsonify({'success': False, 'msg': '更新用户失败，用户名已存在！'})
            os.remove(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            #删除数据库记录
            dealfile = Dealfile(FILENAME=filename, USER_ID=id)
            dealfile.s3_delete(filename)
            db.session.delete(dealfile)
            db.session.commit()
            return jsonify({'success': True, 'filename':filename})
    except:
        return jsonify({'success': False, 'msg': '删除文件失败！'})
