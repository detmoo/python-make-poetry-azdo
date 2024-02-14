import unittest

from bowdata.sandbox.python_package import hello_world as hw


class TestHelloWorld(unittest.TestCase):

    def test_hello_world(self):
        result = hw("world")
        self.assertEqual(result, "hello world")
