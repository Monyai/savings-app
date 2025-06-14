#!/usr/bin/env node

const { WebhookMCPServer } = require('@modelcontextprotocol/server-webhook');
const { SlackAPI } = require('@slack/web-api');

// 監視用MCPサーバー
class MonitoringMCPServer extends WebhookMCPServer {
  constructor() {
    super();
    this.slack = new SlackAPI(process.env.SLACK_BOT_TOKEN);
  }

  async handleGitHubWebhook(payload) {
    const { action, repository, pull_request, pusher } = payload;
    
    let message = '';
    let channel = '#savings-app-dev';
    
    switch (action) {
      case 'opened':
        message = `🔄 新しいPR作成: ${pull_request.title}\n👤 作成者: ${pull_request.user.login}`;
        break;
      case 'closed':
        if (pull_request.merged) {
          message = `✅ PRマージ完了: ${pull_request.title}\n🎉 開発進捗が更新されました！`;
          channel = '#savings-app-dev';
        }
        break;
      case 'push':
        if (pusher.name !== 'claude-code-agent') {
          message = `📝 新しいコミット: ${payload.head_commit?.message}\n👤 コミッター: ${pusher.name}`;
        }
        break;
    }
    
    if (message) {
      await this.slack.chat.postMessage({
        channel,
        text: message,
        username: 'SavingsApp Monitor',
        icon_emoji: ':robot_face:'
      });
    }
  }
}

// サーバー起動
const server = new MonitoringMCPServer();
server.listen(3001);
console.log('🤖 Monitoring MCP Server running on port 3001');
