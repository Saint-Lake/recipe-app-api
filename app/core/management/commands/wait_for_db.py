"""
Django command to wait for the database to be available.
"""
import time

from psycopg2 import OperationalError as Psycopg2Error

from django.db.utils import OperationalError
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    """Django command ot wait for database."""

    def handle(self, *args, **optins):
        """Entrypoing for command."""
        self.stdout.write('waiting for database...')
        db_up = False
        while db_up is False:
            try:
                self.check(databases=['default'])
                db_up = True
            except (Psycopg2Error,OperationalError):
                self.stdout.write('DB unavailable waiting....')
                time.sleep(1)
        self.stdout.write(self.style.SUCCESS('DB is available!'))

    