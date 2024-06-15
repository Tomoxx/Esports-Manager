<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class TournamentRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'name' => ['required', 'min:2'],
            'game' => ['required', 'min:2'],
            'type' => ['required', Rule::in(['Online', 'Offline'])],
            'start_date' => ['required', 'date_format:Y-m-d'], // Specific date format
            'end_date' => ['required', 'date_format:Y-m-d'],   // Specific date format
        ];
    }

    public function messages()
    {
        return [
            'name.required' => 'The name field is required.',
            'name.min' => 'The name must be at least 2 characters.',
            'game.required' => 'The game field is required.',
            'game.min' => 'The game must be at least 2 characters.',
            'type.required' => 'The type field is required.',
            'type.in' => 'The type must be either Online or Offline.',
            'start_date.required' => 'The start date field is required.',
            'start_date.date_format' => 'The start date must be in the format YYYY-MM-DD.',
            'end_date.required' => 'The end date field is required.',
            'end_date.date_format' => 'The end date must be in the format YYYY-MM-DD.',
        ];
    }
}
