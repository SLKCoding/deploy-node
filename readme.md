# Deploy

## Local (Windows)

```powershell
code %userprofile%\.ssh\config
```

Add SSH host:

```plaintext
Host hostname
    HostName 123.123.123.132
    User username
```

### Remember to fill the variables in the deploy script

Copy script to server:

```powershell
scp deploy.sh certbot.sh nginx-site hostname:~
```

## Server

```bash
chmod +x ./deploy.sh && chmod +x ./certbot.sh
```

- Create deploy user and install docker, nginx:

```bash
./deploy.sh
```
