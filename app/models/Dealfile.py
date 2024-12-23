from uuid import uuid4
import boto
import os.path
from werkzeug.utils import secure_filename
# coding:utf-8
from app import db
from flask_login import UserMixin, AnonymousUserMixin
from datetime import datetime

#角色资源关联表
role_resource_table = db.Table('SYROLE_SYRESOURCE', db.metadata,
                               db.Column('SYROLE_ID', db.String, db.ForeignKey('SYROLE.ID')),
                               db.Column('SYRESOURCE_ID', db.String, db.ForeignKey('SYRESOURCE.ID')))

class Dealfile(db.Model, UserMixin):

    def __init__(self, DEAL_ID, FILE_NAME, FILE_URL, FILE_SIZE, UPLOAD_TIME, UPLOAD_USER_ID, UPLOAD_USER_NAME, UPLOAD_USER_EMAIL, UPLOAD_USER_PHONE, UPLOAD_USER_ROLE, UPLOAD_USER_CREATOR, UPLOAD_USER_CREATE_TIME):
            self.ID = uuid4().hex
            self.DEAL_ID = DEAL_ID
            self.FILE_NAME = FILE_NAME
            self.FILE_URL = FILE_URL
            self.FILE_SIZE = FILE_SIZE
            self.UPLOAD_TIME = UPLOAD_TIME
            self.UPLOAD_USER_ID = UPLOAD_USER_ID
            self.UPLOAD_USER_NAME = UPLOAD_USER_NAME
            self.UPLOAD_USER_EMAIL = UPLOAD_USER_EMAIL
            self.UPLOAD_USER_PHONE = UPLOAD_USER_PHONE
            self.UPLOAD_USER_ROLE = UPLOAD_USER_ROLE
            self.UPLOAD_USER_CREATOR = UPLOAD_USER_CREATOR
            self.UPLOAD_USER_CREATE_TIME = UPLOAD_USER_CREATE_TIME
    def __repr__(self):
            return '<Dealfile %r>' % self.ID

    def s3_delete(filename, upload_dir=None):
        """ Deletes a file from Amazon S3

            Expects following app.config attributes to be set:
                S3_KEY              :   S3 API Key
                S3_SECRET           :   S3 Secret Key
                S3_BUCKET           :   What bucket to delete from
                S3_UPLOAD_DIRECTORY :   Which S3 Directory.

            The default deletes the file from the S3_UPLOAD_DIRECTORY.
        """
        if upload_dir is None:
            upload_dir = app.config["S3_UPLOAD_DIRECTORY"]
        # Connect to S3 and delete file.
        conn = boto.connect_s3(app.config["S3_KEY"], app.config["S3_SECRET"])
        b = conn.get_bucket(app.config["S3_BUCKET"])
        sml = b.get_key("/".join([upload_dir, filename]))
        sml.delete()
        return True

    def s3_download(filename, upload_dir=None):
        """ Downloads a file from Amazon S3

            Expects following app.config attributes to be set:
                S3_KEY              :   S3 API Key
                S3_SECRET           :   S3 Secret Key
                S3_BUCKET           :   What bucket to download from
                S3_UPLOAD_DIRECTORY :   Which S3 Directory.

            The default downloads the file from the S3_UPLOAD_DIRECTORY.
        """

        if upload_dir is None:
            upload_dir = app.config["S3_UPLOAD_DIRECTORY"]
        # Connect to S3 and download file.
        conn = boto.connect_s3(app.config["S3_KEY"], app.config["S3_SECRET"])
        b = conn.get_bucket(app.config["S3_BUCKET"])
        sml = b.get_key("/".join([upload_dir, filename]))
        return sml.get_contents_as_string() # Returns file as string.

    def s3_upload(source_file, upload_dir=None, acl='public-read'):
        """ Uploads WTForm File Object to Amazon S3

            Expects following app.config attributes to be set:
                S3_KEY              :   S3 API Key
                S3_SECRET           :   S3 Secret Key
                S3_BUCKET           :   What bucket to upload to
                S3_UPLOAD_DIRECTORY :   Which S3 Directory.

            The default sets the access rights on the uploaded file to
            public-read.  It also generates a unique filename via
            the uuid4 function combined with the file extension from
            the source file.
        """

        if upload_dir is None:
            upload_dir = app.config["S3_UPLOAD_DIRECTORY"]

        source_filename = secure_filename(source_file.data.filename)
        source_extension = os.path.splitext(source_filename)[1]

        destination_filename = uuid4().hex + source_extension

        # Connect to S3 and upload file.
        conn = boto.connect_s3(app.config["S3_KEY"], app.config["S3_SECRET"])
        b = conn.get_bucket(app.config["S3_BUCKET"])

        sml = b.new_key("/".join([upload_dir, destination_filename]))
        sml.set_contents_from_string(source_file.data.read())
        sml.set_acl(acl)
        return destination_filename