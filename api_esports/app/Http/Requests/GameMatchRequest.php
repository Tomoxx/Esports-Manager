<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class GameMatchRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules()
    {
        return [
            'match_date' => ['required', 'date_format:Y-m-d H:i'],
            'home_team_score' => ['required', 'integer', 'min:0'],
            'away_team_score' => ['required', 'integer', 'min:0'],
        ];
    }

    public function messages()
    {
        return [
            'match_date.required' => 'The match date field is required.',
            'match_date.date_format' => 'The match date must be in the format YYYY-MM-DD HH:mm.',
            'home_team_score.required' => 'The home team score field is required.',
            'home_team_score.integer' => 'The home team score must be an integer.',
            'home_team_score.min' => 'The home team score must be at least 0.',
            'away_team_score.required' => 'The away team score field is required.',
            'away_team_score.integer' => 'The away team score must be an integer.',
            'away_team_score.min' => 'The away team score must be at least 0.',
        ];
    }
}
