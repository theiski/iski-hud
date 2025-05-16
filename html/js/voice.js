const voiceApp = {
    data() {
        return {
            isTalking: false,
            isRadio: false,
            voiceMode: 2
        }
    },
    mounted() {
        window.addEventListener('message', this.handleMessage);
    },
    methods: {
        handleMessage(event) {
            const data = event.data;
            
            if (data.action === "updateVoiceState") {
                this.isTalking = data.isTalking;
                this.isRadio = data.isRadio;
                this.voiceMode = data.voiceMode;
            }
        }
    }
};

// Create a separate Vue instance for the voice indicator
const voiceIndicator = Vue.createApp(voiceApp);
voiceIndicator.mount('#voice-container'); 
