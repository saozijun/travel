<template>
    <div class="travel-expert-container">
      <div class="chat-header">
        <h1>AI旅游助手</h1>
        <p>向我询问任何旅游相关的问题，获取专业建议</p>
      </div>
      
      <div class="chat-messages" ref="chatContainer">
        <div v-for="(message, index) in messages" :key="index" 
             :class="['message', message.role === 'user' ? 'user-message' : 'ai-message']">
          <div class="message-content">
            <div class="avatar">
              <img :src="message.role === 'user' ? userStore.avatar : '/src/assets/images/ai-avatar.png'" 
                   :alt="message.role === 'user' ? '用户' : 'AI旅游专家'">
            </div>
            <div class="text">
              <div class="role">{{ message.role === 'user' ? '我' : 'AI旅游专家' }}</div>
              <div class="content" v-html="formatMessage(message.content)"></div>
            </div>
          </div>
        </div>
        <div v-if="loading" class="loading-indicator">
          <div class="dot"></div>
          <div class="dot"></div>
          <div class="dot"></div>
        </div>
      </div>
      
      <div class="chat-input">
        <textarea 
          v-model="userInput" 
          placeholder="输入您的旅游问题，例如：推荐三月适合旅游的城市..." 
          @keydown.enter.prevent="sendMessage"
          :disabled="loading"
        ></textarea>
        <button @click="sendMessage" :disabled="loading || !userInput.trim()">
            发送
        </button>
      </div>
      
      <div class="suggestion-chips">
        <button 
          v-for="(suggestion, index) in suggestions" 
          :key="index" 
          @click="usesuggestion(suggestion)"
          :disabled="loading"
        >
          {{ suggestion }}
        </button>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted, nextTick, watch } from 'vue';
  import { sendToTravelExpert } from '~/api/ai';
  import { useUserStore } from '~@/stores/user'

  const userStore = useUserStore()
  const userInput = ref('');
  const messages = ref([
    {
      role: 'ai',
      content: '你好！我是你的AI旅游专家。无论是寻找目的地推荐、规划行程、了解景点，还是获取预算和安全建议，我都能帮到你。请告诉我你的旅行计划或问题吧！'
    }
  ]);
  const loading = ref(false);
  const chatContainer = ref(null);
  
  const suggestions = ref([
    '推荐适合家庭旅游的目的地',
    '北京三日游行程规划',
    '去日本旅游需要准备什么',
    '五千元预算可以去哪里旅游',
    '最适合拍照的旅游景点'
  ]);

  const scrollToBottom = () => {
    nextTick(() => {
      if (chatContainer.value) {
        chatContainer.value.scrollTop = chatContainer.value.scrollHeight;
      }
    });
  };

  const formatMessage = (content) => {
    // 简单的Markdown格式转换为HTML
    if (!content) return '';
    
    // 处理标题
    content = content.replace(/#{1,6}\s+(.*?)(?:\n|$)/g, (match, title) => {
      const level = match.trim().indexOf(' ');
      return `<h${level}>${title}</h${level}>`;
    });
    
    // 处理粗体
    content = content.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
    
    // 处理斜体
    content = content.replace(/\*(.*?)\*/g, '<em>$1</em>');
    
    // 处理链接
    content = content.replace(/\[(.*?)\]\((.*?)\)/g, '<a href="$2" target="_blank">$1</a>');
    
    // 处理无序列表
    content = content.replace(/^\s*[-*+]\s+(.*?)(?:\n|$)/gm, '<li>$1</li>');
    content = content.replace(/<li>(.*?)<\/li>(?:\s*<li>)/g, '<li>$1</li><li>');
    content = content.replace(/(<li>.*?<\/li>)+/g, '<ul>$&</ul>');
    
    // 处理有序列表
    content = content.replace(/^\s*\d+\.\s+(.*?)(?:\n|$)/gm, '<li>$1</li>');
    content = content.replace(/<li>(.*?)<\/li>(?:\s*<li>)/g, '<li>$1</li><li>');
    content = content.replace(/(<li>.*?<\/li>)+/g, '<ol>$&</ol>');
    
    // 处理换行
    content = content.replace(/\n/g, '<br>');
    
    return content;
  };

  const sendMessage = async () => {
    if (!userInput.value.trim() || loading.value) return;
    
    const userMessage = userInput.value.trim();
    messages.value.push({
      role: 'user',
      content: userMessage
    });
    
    userInput.value = '';
    loading.value = true;
    scrollToBottom();
    
    try {
      const { data } = await sendToTravelExpert(userMessage);
      
      messages.value.push({
        role: 'ai',
        content: data
      });
    } catch (error) {
      console.error('发送消息失败:', error);
      messages.value.push({
        role: 'ai',
        content: '抱歉，我遇到了一些问题，无法回应您的请求。请稍后再试。'
      });
    } finally {
      loading.value = false;
      scrollToBottom();
    }
  };

  const usesuggestion = (suggestion) => {
    userInput.value = suggestion;
    sendMessage();
  };

  watch(messages, () => {
    scrollToBottom();
  }, { deep: true });

  onMounted(() => {
    scrollToBottom();
  });
  </script>
  
  <style scoped>
  .travel-expert-container {
    display: flex;
    flex-direction: column;
    height: calc(100vh - 180px);
    max-width: 1000px;
    margin: 0 auto;
    background-color: #f5f7fa;
    border-radius: 10px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
    overflow: hidden;
  }
  
  .chat-header {
    background: linear-gradient(135deg, #42b0ff, #4a6bff);
    color: white;
    padding: 20px;
    text-align: center;
  }
  
  .chat-header h1 {
    margin: 0;
    font-size: 24px;
  }
  
  .chat-header p {
    margin: 5px 0 0;
    font-size: 14px;
    opacity: 0.8;
  }
  
  .chat-messages {
    flex: 1;
    overflow-y: auto;
    padding: 20px;
    display: flex;
    flex-direction: column;
    gap: 16px;
  }
  
  .message {
    display: flex;
    margin-bottom: 16px;
  }
  
  .message-content {
    display: flex;
    max-width: 80%;
  }
  
  .user-message {
    justify-content: flex-end;
  }
  
  .user-message .message-content {
    flex-direction: row-reverse;
  }
  
  .avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    margin: 0 10px;
    flex-shrink: 0;
  }
  
  .avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .text {
    background-color: white;
    padding: 12px 16px;
    border-radius: 18px;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
  }
  
  .user-message .text {
    background-color: #4a6bff;
    color: white;
    border-top-right-radius: 4px;
  }
  
  .ai-message .text {
    background-color: white;
    border-top-left-radius: 4px;
  }
  
  .role {
    font-weight: bold;
    font-size: 14px;
    margin-bottom: 4px;
  }
  
  .content {
    font-size: 15px;
    line-height: 1.5;
  }
  
  .content :deep(ul), .content :deep(ol) {
    padding-left: 20px;
    margin: 8px 0;
  }
  
  .content :deep(li) {
    margin-bottom: 4px;
  }
  
  .content :deep(h1), .content :deep(h2), .content :deep(h3), 
  .content :deep(h4), .content :deep(h5), .content :deep(h6) {
    margin: 12px 0 8px;
  }
  
  .content :deep(a) {
    color: #4a6bff;
    text-decoration: none;
  }
  
  .content :deep(a:hover) {
    text-decoration: underline;
  }
  
  .chat-input {
    display: flex;
    padding: 16px;
    background-color: white;
    border-top: 1px solid #e6e6e6;
  }
  
  textarea {
    flex: 1;
    border: 1px solid #ddd;
    border-radius: 20px;
    padding: 12px 16px;
    resize: none;
    height: 43px;
    font-family: inherit;
    font-size: 15px;
    outline: none;
    transition: border-color 0.3s;
  }
  
  textarea:focus {
    border-color: #4a6bff;
  }
  
  button {
    background-color: #4a6bff;
    color: white;
    border: none;
    border-radius: 50%;
    width: 43px;
    height: 43px;
    margin-left: 10px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    transition: background-color 0.3s;
  }
  
  button:hover {
    background-color: #3a5bef;
  }
  
  button:disabled {
    background-color: #a0a0a0;
    cursor: not-allowed;
  }
  
  .suggestion-chips {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    padding: 0 16px 16px;
    background-color: white;
  }
  
  .suggestion-chips button {
    background-color: #eef2ff;
    color: #4a6bff;
    border-radius: 20px;
    padding: 8px 16px;
    font-size: 14px;
    height: auto;
    width: auto;
  }
  
  .suggestion-chips button:hover {
    background-color: #dce4ff;
  }
  
  .loading-indicator {
    display: flex;
    justify-content: center;
    margin: 10px 0;
  }
  
  .dot {
    width: 8px;
    height: 8px;
    background-color: #4a6bff;
    border-radius: 50%;
    margin: 0 4px;
    animation: bounce 1.5s infinite ease-in-out;
  }
  
  .dot:nth-child(1) {
    animation-delay: 0s;
  }
  
  .dot:nth-child(2) {
    animation-delay: 0.2s;
  }
  
  .dot:nth-child(3) {
    animation-delay: 0.4s;
  }
  
  @keyframes bounce {
    0%, 80%, 100% {
      transform: translateY(0);
    }
    40% {
      transform: translateY(-10px);
    }
  }
  
  /* 响应式设计 */
  @media (max-width: 768px) {
    .message-content {
      max-width: 90%;
    }
    
    .suggestion-chips button {
      font-size: 12px;
      padding: 6px 12px;
    }
  }
  </style>