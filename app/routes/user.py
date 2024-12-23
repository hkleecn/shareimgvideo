# coding:utf-8
from ..base import base
from ..models import User, Organization, Role
from flask import render_template, request
from flask import g, jsonify
import hashlib
from flask_login import login_user, logout_user, login_required, \
    current_user
from datetime import datetime
from .. import  db
import uuid
from loguru import logger

@base.route('/login', methods=['GET'])
def login():
    return render_template('index.html')

@base.route('/base/syuser!grantOrganization.action', methods=['POST'])
def grant_user_organization():
    id = request.form.get('id')
    ids = request.form.get('ids')
    user = User.query.get(id)

    if not ids:
        user.organizations = []
    else:
        idList = ids.split(',')
        user.organizations = [Organization.query.get(rid) for rid in idList]

    db.session.add(user)
    db.session.commit()
    return jsonify({'success': True})

@base.route('/base/syuser!grantRole.action', methods=['POST'])
def grant_user_role():
    id = request.form.get('id')
    ids = request.form.get('ids')

    user = User.query.get(id)

    if not ids:
        user.roles = []
    else:
        idList = ids.split(',')
        user.roles = [Role.query.get(rid) for rid in idList]

    db.session.add(user)
    db.session.commit()
    return jsonify({'success': True})

@base.route('/base/syuser!doNotNeedSessionAndSecurity_logout.action', methods=['POST'])
def do_logout():
    logout_user()
    return jsonify({'success': True})

@base.route('/base/syuser!doNotNeedSessionAndSecurity_login.action', methods=['POST'])
def do_login():
    #检查用户名是否存在
    user = User.query.filter_by(LOGINNAME=request.form['data.loginname']).first()
    if user is not None:
        md = hashlib.md5()
        #提交的密码MD5加密
        md.update(request.form['data.pwd'].encode('utf-8'))
        #MD5加密后的内容同数据库密码比较
        if md.hexdigest() == user.PWD:
            login_user(user)
            return jsonify({'success': True, 'msg': ''})
    return jsonify({'success': False, 'msg': 'password error'})

@base.route('/securityJsp/base/Syuser.jsp', methods=['GET'])
def index_user():
    return render_template('user/index.html')

@base.route('/base/syuser!grid.action', methods=['POST'])
def user_grid():
    page = request.form.get('page', 1, type=int)
    rows = request.form.get('rows', 10, type=int)
    pagination = User.query.paginate(
        page, per_page=rows, error_out=False)
    users = pagination.items

    return jsonify([user.to_json() for user in users])

@base.route('/base/syuser!getById.action', methods=['POST'])
def syuser_getById():
    user = User.query.get(request.form.get('id'))

    if user:
        return jsonify(user.to_json())
    else:
        return jsonify({'success': False, 'msg': 'error'})

@base.route('/base/syuser!update.action', methods=['POST'])
def syuser_update():
    id = request.form.get('data.id')
    loginname = request.form.get('data.loginname')
    
    if User.query.filter(User.LOGINNAME == loginname).filter(User.ID != id).first():
        return jsonify({'success': False, 'msg': '更新用户失败，用户名已存在！'})

    user = User.query.get(id)

    user.UPDATEDATETIME = datetime.now()
    user.NAME = request.form.get('data.name')
    user.SEX = request.form.get('data.sex')
    user.PHOTO = request.form.get('data.photo')
    user.EMAIL = request.form.get('data.email')
    user.MOBILE = request.form.get('data.mobile')
    user.STATUS = request.form.get('data.status')
    user.PWD = request.form.get('data.pwd')
    user.ORGANIZATIONID = request.form.get('data.organizationid')
    db.session.add(user)
    db.session.commit()
    return jsonify({'success': True, 'msg': '更新成功！'})

@base.route('/base/syuser!save.action', methods=['POST'])
def syuser_save():
    if User.query.filter_by(LOGINNAME = request.form.get('data.loginname')).first():
        return jsonify({'success': False, 'msg': '新建用户失败，用户名已存在！'})

    user = User()

    user.ID = str(uuid.uuid4())

    md = hashlib.md5()
    md.update('123456'.encode('utf-8'))
    user.PWD = md.hexdigest()

    user.NAME = request.form.get('data.name')
    user.LOGINNAME = request.form.get('data.loginname')
    user.SEX = request.form.get('data.sex')
    user.PHOTO = request.form.get('data.photo')
    user.CREATEDATETIME = datetime.now()
    user.UPDATEDATETIME = datetime.now()
    db.session.add(user)
    db.session.commit()
    return jsonify({'success': True, 'msg': '新建用户成功！默认密码：123456'})

@base.route('/base/syuser!delete.action', methods=['POST'])
def syuser_delete():
    user = User.query.get(request.form.get('id'))
    if user:
        db.session.delete(user)
        db.session.commit()
    return jsonify({'success': True})

@base.route('/base/syuser!addnotice.action', methods=['POST'])
def syuser_addnotice():
    user = User.query.get(request.form.get('id'))
    if user:
        user.NOTICETITLE = request.form.get('data.noticetitle')
        user.NOTICETEXT = request.form.get('data.noticetext')
        user.ISREAD = 0
        user.CREATEDATETIME = datetime.now()
        db.session.add(user)
        db.session.commit()
    return jsonify({'success': True})

@base.route('/base/syuser!deleteNotice.action', methods=['POST'])
def syuser_deleteNotice():
    user = User.query.get(request.form.get('id'))
    if user:
        user.NOTICETITLE = ''
        user.NOTICETEXT = ''
        user.ISREAD = 1
        user.CREATEDATETIME = datetime.now()
        db.session.add(user)
        db.session.commit()
    return jsonify({'success': True})



