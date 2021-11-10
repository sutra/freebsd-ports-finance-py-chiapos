--- setup.py.orig	2021-10-10 08:11:36 UTC
+++ setup.py
@@ -202,6 +202,7 @@ if platform.system() == "Windows":
 else:
     setup(
         name="chiapos",
+        version="1.0.6",
         author="Mariano Sorgente",
         author_email="mariano@chia.net",
         description="Chia proof of space plotting, proving, and verifying (wraps C++)",
