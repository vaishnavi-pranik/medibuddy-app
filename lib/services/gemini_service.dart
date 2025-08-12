import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  // Mock service for demonstration
  // In a real app, you would integrate with Google's Gemini API
  
  Future<String> generateResponse(String prompt) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock responses based on keywords
    String response = _getMockResponse(prompt.toLowerCase());
    
    return response;
  }

  String _getMockResponse(String prompt) {
    if (prompt.contains('headache') || prompt.contains('head')) {
      return '''For headaches, here are some general recommendations:

1. **Stay Hydrated**: Drink plenty of water as dehydration is a common cause
2. **Rest**: Try to rest in a quiet, dark room
3. **Cold/Heat Therapy**: Apply a cold compress to your forehead or a warm compress to your neck
4. **Over-the-counter pain relievers**: Consider acetaminophen or ibuprofen as directed

⚠️ **Seek medical attention if:**
- Sudden severe headache
- Headache with fever, stiff neck, confusion
- Headache after head injury
- Persistent or worsening headaches

Please consult a healthcare provider for proper diagnosis and treatment.''';
    }
    
    if (prompt.contains('sleep') || prompt.contains('insomnia')) {
      return '''Here are some tips for better sleep:

1. **Sleep Schedule**: Go to bed and wake up at the same time daily
2. **Sleep Environment**: Keep your room cool, dark, and quiet
3. **Limit Screen Time**: Avoid screens 1 hour before bedtime
4. **Relaxation**: Try meditation, deep breathing, or reading
5. **Avoid Caffeine**: No caffeine 6 hours before bedtime
6. **Exercise**: Regular exercise, but not close to bedtime

If sleep problems persist for more than 2 weeks, consider consulting a sleep specialist.''';
    }
    
    if (prompt.contains('cold') || prompt.contains('cough') || prompt.contains('fever')) {
      return '''For cold symptoms, here's what you can do:

1. **Rest**: Get plenty of sleep to help your body fight the infection
2. **Fluids**: Drink lots of water, herbal teas, and warm broths
3. **Honey**: A spoonful of honey can soothe throat irritation
4. **Steam**: Inhale steam from a hot shower or bowl of hot water
5. **Salt Water**: Gargle with warm salt water for sore throat

⚠️ **See a doctor if:**
- Fever over 101.3°F (38.5°C)
- Symptoms worsen after 7-10 days
- Difficulty breathing
- Severe headache or sinus pain

Most colds resolve on their own within 7-10 days.''';
    }
    
    if (prompt.contains('fitness') || prompt.contains('exercise')) {
      return '''Here's a beginner-friendly fitness guide:

**For Beginners:**
1. **Start Slow**: 20-30 minutes, 3 times per week
2. **Mix Activities**: Cardio + strength training
3. **Walking**: Great low-impact starting point
4. **Bodyweight Exercises**: Push-ups, squats, planks

**Weekly Structure:**
- Monday: 30-min walk + basic stretching
- Wednesday: Bodyweight circuit (3 sets of 10)
- Friday: 30-min cardio activity you enjoy
- Weekend: Active recovery (yoga, light walk)

**Important:** 
- Listen to your body
- Stay hydrated
- Warm up before and cool down after
- Progress gradually

Consult a fitness professional for personalized plans!''';
    }
    
    if (prompt.contains('nutrition') || prompt.contains('diet') || prompt.contains('food')) {
      return '''Basic nutrition guidelines for healthy eating:

**Balanced Plate Method:**
- 1/2 plate: Vegetables and fruits
- 1/4 plate: Lean proteins
- 1/4 plate: Whole grains

**Daily Essentials:**
- **Water**: 8-10 glasses daily
- **Fruits**: 2-3 servings
- **Vegetables**: 4-5 servings
- **Protein**: Include in every meal
- **Whole Grains**: Choose over refined grains

**Indian Diet Tips:**
- Include dal, quinoa, brown rice
- Use turmeric, ginger, garlic regularly
- Choose seasonal, local produce
- Limit processed foods and added sugars

**Meal Timing:**
- Don't skip breakfast
- Eat every 3-4 hours
- Light dinner 2-3 hours before bed

For specific dietary needs, consult a registered dietitian!''';
    }
    
    if (prompt.contains('medication') || prompt.contains('medicine')) {
      return '''Important medication safety guidelines:

**General Rules:**
1. **Follow Prescriptions**: Take exactly as prescribed
2. **Timing**: Take at consistent times daily
3. **Food Instructions**: Some need food, others empty stomach
4. **Complete Course**: Finish antibiotics even if feeling better

**Safety Tips:**
- Never share medications
- Check expiration dates
- Store properly (temperature, humidity)
- Keep original labels
- Use pill organizers for multiple medications

**When to Contact Doctor:**
- Side effects or allergic reactions
- Missed doses (ask about what to do)
- Drug interactions concerns
- Not feeling better after expected time

⚠️ **Emergency**: Severe allergic reactions (difficulty breathing, swelling) - seek immediate medical attention.

Always consult your healthcare provider for medication-related questions!''';
    }
    
    // Default response
    return '''Thank you for your health question! 

I'm here to provide general health information and guidance. For the most accurate and personalized advice, I always recommend consulting with qualified healthcare professionals.

Some common topics I can help with:
- General wellness tips
- Symptom information (not diagnosis)
- Healthy lifestyle guidance
- Basic first aid information
- Fitness and nutrition basics

Is there a specific health topic you'd like to know more about? Feel free to ask!

**Important**: This information is for educational purposes only and not a substitute for professional medical advice.''';
  }
}
