from app import db, loginmanager
from flask_login import UserMixin, AnonymousUserMixin
from datetime import datetime
import hashlib

@loginmanager.user_loader
def load_user(user_id):
    return User.query.filter(User.ID == user_id).first()

user_organization_table = db.Table('SYUSER_SYORGANIZATION', db.Model.metadata
                                   , db.Column('SYUSER_ID', db.String, db.ForeignKey('SYUSER.ID'))
                                   , db.Column('SYORGANIZATION_ID', db.String, db.ForeignKey('SYORGANIZATION.ID')))

user_role_table = db.Table('SYUSER_SYROLE', db.Model.metadata
                           , db.Column('SYUSER_ID', db.String, db.ForeignKey('SYUSER.ID'))
                           , db.Column('SYROLE_ID', db.String, db.ForeignKey('SYROLE.ID')))

class User(db.Model, UserMixin):
    __tablename__ = 'SYUSER'
    ID = db.Column(db.String(36), primary_key=True)
    CREATEDATETIME = db.Column(db.DateTime, index=True, default=datetime.now)
    UPDATEDATETIME = db.Column(db.DateTime, index=True, default=datetime.now)
    LOGINNAME = db.Column(db.String(100), unique=True, index=True)
    PWD = db.Column(db.String(100))
    NAME = db.Column(db.String(100))
    SEX = db.Column(db.String(1))
    AGE = db.Column(db.Integer)
    PHOTO = db.Column(db.String(200))
    EMPLOYDATE = db.Column(db.DATETIME, default=datetime.now)

    organizations = db.relationship('Organization',
                                    secondary=user_organization_table,
                                    backref=db.backref('users', lazy='dynamic'),)

    roles = db.relationship('Role',
                            secondary=user_role_table,
                            backref=db.backref('users', lazy='dynamic'),
                            lazy="dynamic")

    def get_id(self):
        return str(self.ID)

    def have_permission(self, url):
        permissions = []
        for role in self.roles:
            permissions.extend([resource for resource in role.resources])
        if filter(lambda x: x.URL == url, permissions):
            return True
        permissions = []
        for organization in self.organizations:
            permissions.extend([resource for resource in organization.resources])

        return filter(lambda x: x.NAME == url, permissions)

    def check_password(self, passwd):
        '''
        检查密码
        :param passwd:
        :return: 0/1
        '''
        # 创建md5对象
        m = hashlib.md5()
        b = passwd.encode(encoding='utf-8')
        m.update(b)
        str_md5 = m.hexdigest()
        if self.password == str_md5:
            return 1
        else:
            return 0     
    def __repr__(self):
        return '<User %r>\n' %(self.NAME)

    def to_json(self):
        return {
            'id': self.ID,
            'createdatetime': self.CREATEDATETIME.strftime('%Y-%m-%d %H:%M:%S'),
            'updatedatetime': self.UPDATEDATETIME.strftime('%Y-%m-%d %H:%M:%S'),
            'loginname': self.LOGINNAME,
            'name': self.NAME,
            'sex': self.SEX,
            'age': self.AGE,
            'photo': self.PHOTO,
            #'employdate': self.EMPLOYDATE.strftime('%Y-%m-%d %H:%M:%S'),
        } 

    def add_notice_user(self, user_id, message):
        try:
            user = User.query.filter_by(ID=user_id).first()
            if user:
                user.messages.append(Message(message=message))
                db.session.add(user)
                db.session.commit()
                return True
            else:
                return False
        except Exception as e:
            print(e)
        def send_message(self, user_id, message):
            try:
                user = User.query.filter_by(ID=user_id).first()
                if user:
                    user.messages.append(Message(message=message))
                    db.session.add(user)
                    db.session.commit()
                    return True
                else:
                    return False
            except Exception as e:
                print(e)   
         
    def delete_notice_user(self, user_id):
        try:
            user = User.query.filter_by(ID=user_id).first()
            if user:
                db.session.delete(user)
                db.session.commit()
                return True
            else:
                return False
        except Exception as e:
            print(e)        
        
