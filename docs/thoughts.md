# 🚀 Infrastructure Setup Plan

Ready to build an awesome K3s cluster? Here's the game plan:

## 🛠️ Phase 1: Base Image

1. Start with a minimal Arch Linux VM. Keep it lean and mean! 🐧
2. Add the essentials:
   - User, SSH key, sudo, and either systemd-networkd or netctl.
3. Clean up the mess (cache/logs). 🧹
4. Export it to a raw image.
5. Compress it and crown it as your **golden base**. 👑

## 🌐 Phase 2: Terraform Provisioning

1. Define your dream team: a 5-node setup (1 control, 4 workers). 🖥️
2. Use Libvirt + Terraform magic to:
   - Clone the golden base image. ✨
   - Assign static IPs. 📡
   - Set hostnames. 🏷️
   - Autoconnect to your virtual network. 🌐

## 🤖 Phase 3: Ansible Bootstrap

1. Deploy K3s:
   - Control node: K3s server. 🛡️
   - Worker nodes: K3s agents, ready to serve. ⚙️
2. Install the must-have tools:
   - **MetalLB** for load balancing. ⚖️
   - **Traefik** (or nginx) for ingress. 🚪

## 🔄 Phase 4: GitOps via Flux

1. Install Flux (via Ansible or manually). 🌀
2. Connect it to your Git repo. 🔗
3. Populate the repo with Kustomizations, HelmReleases, and more. 📂
4. Sit back and watch your cluster manage itself. 🧙‍♂️

## 🤖 Phase 5: Renovate Integration

1. Add the Renovate bot to your Git repo. 🤖
2. Configure it to track Helm charts and image tags. 🕵️‍♀️
3. Enjoy auto-PRs for version bumps. 🔄
4. Feeling bold? Set up an auto-merge pipeline. 🚀

## 📊 Phase 6: Observability & Feedback

1. Install the observability stack:
   - **VictoriaMetrics** for metrics. 📈
   - **Alertmanager** for alerts. 🚨
   - **Loki** (optional) for logs. 📜
2. Wire it all up to Slack:
   - Alerts, Flux events, and Renovate PRs → Slack. 💬
   - Use:
     - Alertmanager Slack integration.
     - Flux Notification Controller.
     - GitHub webhooks or Renovate config.

---

## 💡 Thought Process

So, here's the deal: I used to run a bloated Ubuntu server setup. Not fun. 😒  
Since I'm an Arch Linux fan (yes, I use Arch btw 😏), I thought, "Why not use Arch as the base for my VMs?"

Also, QCOW2 images? Meh. They're slower due to copy-on-write. So, I decided to create a **golden Arch image**, finely tuned for my AMD hardware with passthrough. 🎯

### Current Status

As of now, I have 5 VMs running on my host. Here's the load average on the host itself:

```
load average: 0.67, 0.68, 0.65
```

Not bad, but I'm curious to see how this improves with the new setup. 🤔

Oh, and did I mention? The new image boots in **3 seconds flat** on a VM. 🚀  
This part is done. On to the next phase!