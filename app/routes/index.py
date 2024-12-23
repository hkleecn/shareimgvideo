from ..base import base
from flask import render_template
from flask_login import login_user, logout_user, login_required, \
    current_user
from loguru import logger

@base.route('/')
@login_required
def index():
    return render_template('index.html')

@base.route('/style/icons.jsp')
def icons():
    return render_template('index.html')
