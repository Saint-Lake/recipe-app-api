"""
Sample Tests
"""
from django.test import SimpleTestCase

from app import Calc


class CalcTests(SimpleTestCase):
    """ Test the calc module"""

    def test_add_numbers(self):
        """Tests adding numbers together"""
        res = Calc.add(5, 6)

        self.assertEqual(res, 11)

    def test_subtract_number(self):
        """Tests subtracting numbers"""
        res = Calc.subtract(10, 5)

        self.assertEqual(res, 5)
