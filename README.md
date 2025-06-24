# docker-pyAMI-atlas

This Docker container provides a lightweight environment to use **pyAMI** (v5.1.7) for accessing ATLAS metadata through the AMI interface. It supports both **certificate-based** and **login/password-based** authentication.

## 📦 Building the Image

```bash
docker build -t pyami-atlas:5.1.7 .
```

## 📤 Exporting the Image

```bash
docker save -o pyami-atlas-5.1.7.tar pyami-atlas:5.1.7
```

## 📥 Importing the Image

```bash
docker load -i pyami-atlas-5.1.7.tar
```

## 🚀 Using the Container

### 🔧 Command-Line Mode

#### Certificate Authentication

```bash
docker run --rm \
  -e B64_USER_PROXY="$(base64 path_to_my_proxy_file)" \
  pyami-atlas:5.1.7 \
  ami cmd GetSessionInfo
```

#### Login/Password Authentication

```bash
docker run --rm \
  -e AMI_LOGIN="your_login" \
  -e AMI_PASSWORD="your_password" \
  pyami-atlas:5.1.7 \
  ami cmd GetSessionInfo
```

---

### 🐳 Daemon Mode (Background Session)

#### Certificate Authentication

```bash
docker run -d --name pyami-session \
  -e B64_USER_PROXY="$(base64 path_to_my_proxy_file)" \
  pyami-atlas:5.1.7
```

Then execute:

```bash
docker exec pyami-session ami cmd GetSessionInfo
```

#### Login/Password Authentication

```bash
docker run -d --name pyami-session \
  -e AMI_LOGIN="your_login" \
  -e AMI_PASSWORD="your_password" \
  pyami-atlas:5.1.7
```

Then execute:

```bash
docker exec pyami-session ami cmd GetSessionInfo
```

---

### 🖥️ Interactive Mode

#### Certificate Authentication

```bash
docker run -it \
  -e B64_USER_PROXY="$(base64 path_to_my_proxy_file)" \
  pyami-atlas:5.1.7
```

#### Login/Password Authentication

```bash
docker run -it \
  -e AMI_LOGIN="your_login" \
  -e AMI_PASSWORD="your_password" \
  pyami-atlas:5.1.7
```

---

## 🔐 Environment Variables

| Variable Name     | Description                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| `B64_USER_PROXY`  | **(optional)** Base64-encoded X.509 proxy certificate content.              |
| `AMI_LOGIN`       | **(optional)** AMI login username.                                          |
| `AMI_PASSWORD`    | **(optional)** AMI login password.                                          |
| `X509_USER_PROXY` | **(internal)** Automatically set to `/tmp/x509up_u$(id -u)` in the container. |
**Note:**
- If both a proxy certificate (`B64_USER_PROXY`) and login credentials are provided, the proxy takes precedence.
- The proxy is written to `/tmp/x509up_u$(id -u)` inside the container, as required by AMI.
- In daemon mode, authentication is only performed at container startup.
