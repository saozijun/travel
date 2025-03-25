package com.cen.controller;

import com.alibaba.dashscope.aigc.generation.Generation;
import com.alibaba.dashscope.aigc.generation.GenerationParam;
import com.alibaba.dashscope.aigc.generation.GenerationResult;
import com.alibaba.dashscope.common.Message;
import com.alibaba.dashscope.common.Role;
import com.alibaba.dashscope.exception.InputRequiredException;
import com.alibaba.dashscope.exception.NoApiKeyException;
import com.cen.common.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Arrays;

@RestController
@RequestMapping("ai/")
public class AliAliController {

    @Value("${ai-api-key}")
    private String apiKey;

    @Resource
    private Generation generation;


    /**
     * 测试demo
     * @param content 用书输入文本内容
     */
    @PostMapping(value = "aliTyqw")
    public String send(@RequestBody String content) throws NoApiKeyException, InputRequiredException {
        //用户与模型的对话历史。list中的每个元素形式为{“role”:角色, “content”: 内容}。
        Message userMessage = Message.builder()
                .role(Role.USER.getValue())
                .content(content)
                .build();

        GenerationParam param = GenerationParam.builder()
                //指定用于对话的通义千问模型名
                .model("qwen-turbo")
                .messages(Arrays.asList(userMessage))
                //
                .resultFormat(GenerationParam.ResultFormat.MESSAGE)
                //生成过程中核采样方法概率阈值，例如，取值为0.8时，仅保留概率加起来大于等于0.8的最可能token的最小集合作为候选集。
                // 取值范围为（0,1.0)，取值越大，生成的随机性越高；取值越低，生成的确定性越高。
                .topP(0.8)
                //阿里云控制台DASHSCOPE获取的api-key
                .apiKey(apiKey)
                //启用互联网搜索，模型会将搜索结果作为文本生成过程中的参考信息，但模型会基于其内部逻辑“自行判断”是否使用互联网搜索结果。
                .enableSearch(true)
                .build();
        GenerationResult generationResult =generation.call(param);;
        return generationResult.getOutput().getChoices().get(0).getMessage().getContent();
    }

    /**
     * AI旅游专家对话接口
     * @param content 用户输入的旅游相关问题
     * @return AI旅游专家的回答
     */
    @PostMapping(value = "travelExpert")
    public Result travelExpert(@RequestBody String content) throws NoApiKeyException, InputRequiredException {
        // 系统提示，定义AI的角色和行为
        Message systemMessage = Message.builder()
                .role(Role.SYSTEM.getValue())
                .content("你是一位专业的旅游顾问，拥有丰富的全球旅游知识。你可以推荐旅游目的地、制定旅游行程、提供景点介绍、" +
                        "分享当地美食和文化习俗，以及提供旅行安全和预算建议。请用友好、专业的语气回答用户的旅游相关问题。")
                .build();
        
        // 用户消息
        Message userMessage = Message.builder()
                .role(Role.USER.getValue())
                .content(content)
                .build();

        GenerationParam param = GenerationParam.builder()
                // 使用更强大的模型以获得更好的旅游建议
                .model("qwen-plus")
                .messages(Arrays.asList(systemMessage, userMessage))
                .resultFormat(GenerationParam.ResultFormat.MESSAGE)
                .topP(0.8)
                .apiKey(apiKey)
                // 启用互联网搜索以获取最新的旅游信息
                .enableSearch(true)
                .build();
                
        GenerationResult generationResult = generation.call(param);

        return Result.success(generationResult.getOutput().getChoices().get(0).getMessage().getContent());
    }
}